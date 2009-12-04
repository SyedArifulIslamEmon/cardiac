<?php
/* 
 *  Copyright (c) 2009 Denic Wibowo<denicwibowo@gmail.com>.
 *  All rights reserved.
 *  
 *  This program is free software; you can redistribute it and/or modify it 
 *  under the terms of the GNU General Public License as published by the 
 *  Free Software Foundation; either version 2 of the License, or 
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful, but 
 *  WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
 *  Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License along 
 *  with this program; if not, write to the Free Software Foundation, Inc., 
 *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *  

 *  recovery.tpl
 *  
 *  Created on Oct 26, 2009, 5:28:48 AM
 */
$result .= '<div id="fisis' . $ke . '" class="tabcontent">' . "\n";
$result .= $vl['datafields']['FaseRecovery']['title'];
//$result .= '<table width=100% class="table" border="1">' . "\n";

foreach($vl as $key => $value){
//    if(isset($value['#addmenu'])){
//        $result .= __create_add_menu($value['#addmenu']);
//    }
//    $result .= __create_form_open($value, $key);
//    $result .= "\n" . '<fieldset>' . "\n";
//    $result .= '<legend>' . __t('Identitas Pasien') . '</legend>' . "\n";
//    foreach($value as $ky => $vl){
//        if(!eregi('#', $ky)){
//            if($vl['#type'] == 'hidden'){
//                $result .= '<input type="hidden" name="' . $ky . '" value="' . $vl['#value'] . '">' . "\n";
//            }
//        }
//    }
//    $gettbpos = array();
//    foreach($value as $ky => $vl){
//        if(!eregi('#', $ky)){
//            if($ky != 'tab_items'){
//                if(isset($vl['#tbpos'])){
//                    $gettbpos[$vl['#tbpos']] = $vl;
//                    $gettbpos[$vl['#tbpos']]['#key'] = $ky;
//                }
//            }
//        }
//    }
//    ksort($gettbpos);
//    foreach($gettbpos as $ky => $vl){
//        if((int)$ky < 1 || (int)$ky % 5 == 0){
//            $result .= '<div id="kolom">' . "\n";
//            $setdiv = 1;
//        }
//        $result .= '<label>' . ucwords($vl['#title']) . '</label>';
//        if($vl['#type'] != 'textarea'){
//            $result .= '<input type="text" value="' . $vl['#value'] .'" readonly="true"> <br />' . "\n";
//        } else {
//            $result .= '<textarea  readonly="true">' . $vl['#value'] .'</textarea> <br />' . "\n";
//        }
//        if((int)$ky > 3 && ((int)$ky + 1) % 5 == 0){
//            unset($setdiv);
//            $result .= '</div>' . "\n";
//        }
//    } unset($gettbpos);
//    if(isset($setdiv)){
//        $result .= '</div>' . "\n";
//        unset($setdiv);
//    }
//    $result .= '</fieldset>' . "\n";
    
    $result .= '<div>' . "\n";
//    $result .= '<div id="fisis' . $ke . '" class="tabcontent">' . "\n";
    $result .= '<table width=100% class="table" border="0">' . "\n";
    
    foreach($value as $yk => $lv){
//        if(!eregi('#', $yk) && is_array($lv) && $yk != 'submit'){
            if($lv['#type'] != 'hidden' && !isset($lv['#tbpos'])){
                if(isset($lv['#customized'])){
                    if(!isset($rowspan[$lv['#customized']['id']])){$rowspan[$lv['#customized']['id']] = array();}
                    $rowspan[$lv['#customized']['id']][] = $yk;
                }
            }
//        }
    }
    $cnt = 0;
//    echo "<pre>"; print_r($value['datafields']); "</pre>";
    foreach($value as $yk => $lv){
//    foreach($vl['datafields'] as $yk => $lv){
//        echo "<pre>"; print_r($lv); "</pre>";
//        if(!eregi('#', $yk) && is_array($lv) && $yk != 'submit'){
            if($lv['#type'] != 'hidden' && !isset($lv['#tbpos'])){
                $result .= '<tr valign="top">' . "\n";
                if(!isset($lv['#customized'])){
                    $result .= '<td align="right" width="15%">' . ucwords($lv['#title']) . '</td>' . "\n";
                    $result .= '<td align="left" colspan="4">';
                    if($lv['#type'] == 'select'){
                        if(isset($lv['#readonly']) && trim($lv['#readonly']) !== FALSE){
                            $result .= $lv['#theref'][$lv['#value']];
                        } else {
                            $result .= '<select name="' . $yk . '" size="1">';
                            $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>';
                            foreach($lv['#theref'] as $kk => $vv){
                                $result .= '<option value="' . $kk . '"' . (isset($lv['#value']) && $lv['#value'] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>';
                            }
                            $result .= '</select>';
                        }
                    } else {
                        if(isset($lv['#readonly']) && trim($lv['#readonly']) !== FALSE){
                            $result .= $lv['#value'];
                        } else {
                            $result .= '<input type="' . $lv['#type'] . '" name="' . $yk . '"' . (isset($lv['#size']) ? ' size="' . $lv['#size'] . '"' : '') . '>';
                        }
                    }
                    $result .= '</td>' . "\n";
                } else {
                    if(!is_array($lv['#value'])){
                        $lv['#value'] = explode('|', $lv['#value']);
                    }
                    if(!isset($dumpt)){$dumpt = array();}
                    if(!in_array($lv['#customized']['title'], $dumpt)){
                        $dumpt[] = $lv['#customized']['title'];
                        $result .= '<td align="right" rowspan="' . count($rowspan[$lv['#customized']['id']]) . '">' . ucwords($lv['#customized']['title']) . '</td>' . "\n";
                    }
                    $result .= '<td width="15%" align="' . ($yk != 'gelombang_t' ? 'right' : 'left') . '">';
                    if($yk != 'gelombang_t'){
                        $result .= ucwords($lv['#title']);
                    } else {
                        if(isset($lv['#readonly']) && $lv['#readonly'] !== FALSE){
                            $result .= $lv['#value'][0];
                        } else {
                            foreach($lv['#customized']['option'] as $kk => $vv){
                                if(isset($koma)){
                                    $result .= '<br />';
                                }
                                $result .= '<input type="radio" name="' . $yk . '[0]" value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' checked="true"' : '') . '> ' . $vv;
                                $koma = 0;
                            } unset($koma);
                        }
                    }
                    $result .= '</td>' . "\n";
                    $result .= '<td align="left"' . ($lv['#type'] != 'select2' ? ' colspan="2"' : '') . '>';
                    if($yk != 'gelombang_t'){
                        if(isset($lv['#readonly']) && $lv['#readonly'] !== FALSE){
                            $result .= ($lv['#type'] == 'select' ? $lv['#theref'][$lv['#value'][0]] : $lv['#value'][0]) . ($lv['#type'] == 'select' ? '' : ' ' . __t('pada sandapan') . ' ' . $lv['#theref'][$lv['#value'][1]]);
                        } else {
                            if($lv['#type'] == 'select2'){
//                                echo '<pre>'; print_r($lv['#value']); echo '</pre>';
                                $result .= '<select name="' . $yk . '[0]" size="1">';
                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
                                foreach($lv['#customized']['option'] as $kk => $vv){
                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
                                }
                                $result .= '</select>' . "\n";
                            } elseif($lv['#type'] == 'select3') {
                                $result .= '<select name="' . $yk . '[0]" size="1">';
                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
                                foreach($lv['#customized']['option'] as $kk => $vv){
                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
                                }
                                $result .= '</select>' . "\n";
                                $result .= __t('pada sandapan') . "\n";
                                $result .= '<select name="' . $yk . '[1]" size="1">';
                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
                                foreach($lv['#theref'] as $kk => $vv){
                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][1]) && $lv['#value'][1] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
                                }
                                $result .= '</select>' . "\n";
                            } else {
                                $result .= '<select name="' . $yk . '[0]" size="1">';
                                $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
                                foreach($lv['#theref'] as $kk => $vv){
                                    $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][0]) && $lv['#value'][0] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
                                }
                                $result .= '</select>' . "\n";
                            }
                        }
                    } else {
                        $result .= '<br />' . __t('pada sandapan') . "\n";
                        if(isset($lv['#readonly']) && $lv['#readonly'] !== FALSE){
                            $result .= $lv['#theref'][$lv['#value'][1]];
                        } else {
                            $result .= '<select name="' . $yk . '[1]" size="1">' . "\n";
                            $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
                            foreach($lv['#theref'] as $kk => $vv){
                                $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][1]) && $lv['#value'][1] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
                            }
                            $result .= '</select>' . "\n";
                        }
                    }
                    $result .= '</td>' . "\n";
                    if($lv['#type'] == 'select2' && (!isset($lv['#readonly']) || $lv['#readonly'] !== TRUE)){
                        $result .= '<td align="left">' . "\n";
                        $result .= __t('pada sandapan') . "\n";
                        $result .= '<select name="' . $yk . '[1]" size="1">';
                        $result .= '<option value=""> --- ' . __t('Silahkan pilih') . ' --- </option>' . "\n";
                        foreach($lv['#theref'] as $kk => $vv){
                            $result .= '<option value="' . $kk . '"' . (isset($lv['#value'][1]) && $lv['#value'][1] == $kk ? ' selected="selected"' : '') . '>' . $vv . '</option>' . "\n";
                        }
                        $result .= '</select>' . "\n";
                        $result .= '</td>';
                    }
                }
                $result .= '</tr>' . "\n";
                $cnt++;
            }
//        }
    } unset($dumpt, $cnt, $rowspan);
    $result .= '</table>' . "\n";
    $result .= '</div>' . "\n";

//    if(isset($value['submit'])){
//        $result .= '<div>' . "\n";
//        $result .= '<input type="submit" value="' . $value['submit']['#value'] . '"' . (isset($value['submit']['#extra']) ? ' ' . $value['submit']['#extra'] : '') . '>';
//        $result .= '</div>' . "\n";
//    }
//    $result .= __create_form_close();
//    $result .= '<script type="text/javascript">' . "\n";
//    $result .= 'var tabs=new ddtabcontent("fisistabs")' . "\n";
//    $result .= 'tabs.setpersist(true)' . "\n";
//    $result .= 'tabs.setselectedClassTarget("link") //"link" or "linkparent"' . "\n";
//    $result .= 'tabs.init()' . "\n";
//    $result .= '</script>' . "\n";
}