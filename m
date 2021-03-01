Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A2C433E6
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Mar 2021 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCC96510D
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Mar 2021 17:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhCARCK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:02:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29294 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234792AbhCAQ74 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Mar 2021 11:59:56 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-60-ldJHFi9KOjKwpI4jjguaoQ-1; Mon, 01 Mar 2021 16:55:12 +0000
X-MC-Unique: ldJHFi9KOjKwpI4jjguaoQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 1 Mar 2021 16:55:09 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 1 Mar 2021 16:55:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cxl: Make loop variable be 'i' instead of 'j'
Thread-Topic: [PATCH v2] cxl: Make loop variable be 'i' instead of 'j'
Thread-Index: AQHXDITnpuSc/NuooE2Hlm/1gHtj5qpvXgLg
Date:   Mon, 1 Mar 2021 16:55:09 +0000
Message-ID: <9c4643b7200449ce8e6693e4bcaf24b6@AcuMS.aculab.com>
References: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
 <20210226211656.46359-1-konrad.wilk@oracle.com>
In-Reply-To: <20210226211656.46359-1-konrad.wilk@oracle.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Konrad Rzeszutek Wilk
> Sent: 26 February 2021 21:17
> 
> .. otherwise people spend extra cycles looking for the
> inner loop and wondering 'why j'?
> 
> This was an oversight when initial work was rebased
> so let's fix it here.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
> v1: Initial posting
> v2: Fix per Dan's request
> ---
>  drivers/cxl/mem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 244cb7d89678..d43197a193ce 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -698,7 +698,6 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  	struct device *dev = &cxlmd->dev;
>  	struct cxl_mem_command *cmd;
>  	u32 n_commands;
> -	int j = 0;
> 
>  	dev_dbg(dev, "Query IOCTL\n");
> 
> @@ -715,11 +714,12 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  	 */
>  	cxl_for_each_cmd(cmd) {
>  		const struct cxl_command_info *info = &cmd->info;
> +		int i = 0;
> 
> -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> +		if (copy_to_user(&q->commands[i++], info, sizeof(*info)))
>  			return -EFAULT;
> 
> -		if (j == n_commands)
> +		if (i == n_commands)
>  			break;


Did you test this?
Looks badly broken to me.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

