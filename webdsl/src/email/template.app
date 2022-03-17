module template

imports src/entities

template emailTemplate(u: User){
	<head>
    <meta charset="utf-8"></meta>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"></meta>
    <title></title>
    <style type="text/css">@media only screen and (max-width:575px){.col-sm-5{width:41.66% !important;max-width:41.66% !important}.col-sm-9{width:75% !important;max-width:75% !important}.h-sm-48px{height:48px !important}.h-sm-64px{height:64px !important}.p-sm-32px{padding:32px !important}}</style>
    <meta name="x-apple-disable-message-reformatting"></meta>
    <meta name="format-detection" content="telephone=no,address=no,email=no,date=no,url=no"></meta>
    <style type="text/css">
        a {
            text-decoration: none;
        }
    </style>
    <!--[if mso]>
		<xml>
		<o:OfficeDocumentSettings>
			<o:AllowPNG/>
			<o:PixelsPerInch>96</o:PixelsPerInch>
		</o:OfficeDocumentSettings>
		</xml>

		<style type="text/css">
			.col, div.col { width:100% !important; max-width:100% !important; }
			.hidden-outlook, .hidden-outlook table { 
				display:none !important;
				mso-hide:all !important;
			}
		
			* {
				font-family: sans-serif !important;
				-ms-text-size-adjust: 100%;
			}

			img {
				-ms-interpolation-mode:bicubic;
			}

			td.body-content {
				width: 680px;
			}

			td.row-content {
				font-size:0;
			}
		</style>
	<![endif]-->
	<!--[if !mso]><!-->
	<style type="text/css">

        .visible-outlook {
            display: none !important;
        }

        a[x-apple-data-detectors],
        .unstyle-auto-detected-links a {
            border-bottom: 0 !important;
            cursor: default !important;
            color: inherit !important;
            text-decoration: none !important;
            font-size: inherit !important;
            font-family: inherit !important;
            font-weight: inherit !important;
            line-height: inherit !important;
        }
    </style>
    <!--<![endif]-->
	<!--[if mso]><style type="text/css">.ms-t1{line-height:1.45;font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;color:#212529;font-size:16px;text-align:left;font-weight:400}</style><![endif]-->
</head>

<body style="background: #252732;margin: 0 auto;padding: 0;width: 100%;height: 100%;background-color: #252732;">
    <table role="presentation" cellspacing="0" cellpadding="0" width="100%" style="background: #252732;border-collapse: collapse;background-color: #252732;">
        <tbody>
            <tr><!--[if mso]>
 <td></td> <![endif]--><td class="body-content" style="font-size: 16px;font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif;color: #212529;font-weight: normal;line-height: 1.45;text-align: left;-webkit-text-size-adjust: 100%;-ms-text-size-adjust: 100%;">
                    <table class="ms-t1 spacer h-sm-64px" role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;width: 100%;height: 96px;">
                        <tbody>
                            <tr>
                                <td width="100%" height="96"></td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="row h-align-center v-align-middle" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse: collapse;width: 100%;">
                        <tbody>
                            <tr>
                                <td class="row-content" style="vertical-align: top;text-align: center;"><!--[if mso]>
<table role="presentation" border="0" cellpadding="0" cellspacing="0" width="25%" style="width:25%;">
<tr>
<td style="vertical-align:middle;width:100%;" width="100%">
<![endif]--><div class="col col-3 col-sm-5" style="text-align: left;display: inline-block;width: 25%;max-width: 25%;vertical-align: middle;">
                                        <table class="ms-t1 col-table" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse: collapse;width: 100%;vertical-align: top;">
                                            <tbody>
                                                <tr>
                                                    <td class="col-content" style="vertical-align: top;"><!--[if mso]>image("/images/logo.png")[class="img-fluid", width="170", style="display: block;height: auto;max-width: 100%;"]<![endif]--><!--[if !mso]><!-->image("/images/logo.png")[class="img-fluid", style="display: block;height: auto;max-width: 100%;"]<!--<![endif]--></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div><!--[if mso]>
</td>
</tr></table>
<![endif]--></td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="ms-t1 spacer h-sm-48px" role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;width: 100%;height: 64px;">
                        <tbody>
                            <tr>
                                <td width="100%" height="64"></td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="row h-align-center v-align-middle" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse: collapse;width: 100%;">
                        <tbody>
                            <tr>
                                <td class="row-content" style="vertical-align: top;text-align: center;"><!--[if mso]>
<table role="presentation" border="0" cellpadding="0" cellspacing="0" width="66%" style="width:66%;">
<tr>
<td style="vertical-align:middle;width:100%;" width="100%">
<![endif]--><div class="col col-8 col-sm-9" style="text-align: left;display: inline-block;filter: drop-shadow(0 0 12px rgba(0, 0, 0, 1));width: 66.66%;max-width: 66.66%;vertical-align: middle;">
                                        <table class="ms-t1 col-table" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse: collapse;width: 100%;vertical-align: top;">
                                            <tbody>
                                                <tr>
                                                    <td class="col-content p-sm-32px pt-sm-16px pb-sm-16px" style="background: #f8f8f2;vertical-align: top;background-color: #f8f8f2;padding: 64px;border-radius: 16px;padding-top: 16px;padding-bottom: 16px;">
                                                    	elements
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div><!--[if mso]>
</td>
</tr></table>
<![endif]--></td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="ms-t1 spacer" role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;width: 100%;height: 32px;">
                        <tbody>
                            <tr>
                                <td width="100%" height="32"></td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="ms-t1 box" role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;width: 100%;">
                        <tbody>
                            <tr>
                                <td>
                                    <table role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;width: 100%;" class="ms-t1">
                                        <tbody>
                                            <tr>
                                                <td class="box-content" align="center" style="vertical-align: middle;">
                                                    <p class="text-center" style="margin: 0 0 10px 0;mso-line-height-rule: exactly;color: rgb(248,248,242);text-align: center;">
                                                        navigate unsubscribe(u)[style="color: #9048f4;text-decoration: underline;font-size: 10px;"]{ "Unsubscribe from newsletter" }
                                                    </p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="ms-t1 spacer h-sm-64px" role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;width: 100%;height: 96px;">
                        <tbody>
                            <tr>
                                <td width="100%" height="96"></td>
                            </tr>
                        </tbody>
                    </table>
                </td><!--[if mso]>
 <td></td> <![endif]--></tr>
        </tbody>
    </table>
</body>
}