Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E7C25B0E
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiHPU42 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 16:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiHPU41 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 16:56:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333DB74376;
        Tue, 16 Aug 2022 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660683386; x=1692219386;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vUXz08t51rvyBdv1OPyQ4LBvo/zDV7pVay2+U7rHU0s=;
  b=It2AgYvWqMCeCRRkKQdNMmyJOmD4oyVaC4M/whFLqsZz8DAhj69sTnDG
   ahSdmLF3C+ucF+X0yCzF0Cy25AY83D+cyNsHVJUvBsylEKopcGOgCk9To
   fWJvZDbMqgDAsXh7zOSgjZQBCtTGEk7EwkmdpkjxMZlubKsWGJiL//yXp
   V23DZWOqEuhPUcqTah4B6wziO2vjfmAdiUKry3cY5dZF/GTe/a3H0LXEM
   QH/I11YiL8R2036BsRdcGDL3ZWjVgZprcKGpjwByiJGRrJm3w8GCu6zAk
   7hLdWkBYJ3BUOguUHf7Dd6QttHtbShI5aFL8EJEaJwQ8Cy+LnPLo2907m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="275381220"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="275381220"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 13:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="852787959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2022 13:56:25 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 13:56:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 13:56:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 13:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB4/EPp3rxTUYf7VEr4FofErqNOz8uxW6ICIaP4kN+vvAklWFrMIcvDFTF+7NbRLsvEIQ1/VpjEIrGJkHpG6awCmyfbb2e++MagsHlPjdcUK3yT5nJmQGdo3fVy5cLn5gfUOnDiUeQBQrORem4Z4zWpv+qZwyfu30y8rel1md25sIHMlK1B+CGVQuh+lQeVECzeqcLn1bUrNHYeYSnms0m8LKtSoNWacwEuvalgFd8rXRQyisLXx30VlrJYIt55SJvXjJwG1tMuMNwUby48PXb+J/Va8BE/dCQmFTRg4fpyHYR2qvw79vI1qWfNQqHw2LoGGJyaiYa5Qq1mGn6g3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0H/I0gM0YD+Ywr/4nPjXXtbIcE7dNqcgc68J4hZJ9Q=;
 b=CIeDuXthAFcTgnxmWXhiACBa0Ias0onPIVjy9itOmPal7gYhmQ0E9wcdx2Bjf4Q/LFE1hv4LoC4vw1lki9ah1/o8M+NhNrMcN7JNXEaAU8xdMj7y8AQBrTX0JW0IZbYX5xm4ZIAYVIVEXp5ocK8JmHQkE9ZjgywoLijKbhmK5QelxLe++Qq8JcxekWH7YgyjoygCn6j2hvYQ/AK+OS1Bj+s5kdx/gJPSgJ1cYarUYBQdlEkU5te+MbyWGgPa4v+Ohfw6e36xFwcM5mnxb8NR80EZ31DXhjpcd0K2XzgymGbmoXHMJTUpXF/Rvuy+RAa0h+t/62elVY7HIkqTIEt8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN8PR11MB3572.namprd11.prod.outlook.com
 (2603:10b6:408:82::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 20:56:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 20:56:12 +0000
Date:   Tue, 16 Aug 2022 13:56:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] cxl/hdm: unlock on error in cxl_decoder_commit()
Message-ID: <62fc046a8037e_f2f51294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <Yvuv9wQrtXBy4Ddr@kili>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvuv9wQrtXBy4Ddr@kili>
X-ClientProxiedBy: BYAPR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f6719f6-af56-47f0-8db4-08da7fc9c0b8
X-MS-TrafficTypeDiagnostic: BN8PR11MB3572:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89eXcMDx18+Du3ExKZTAnay/G9wt6hjrkK//a+ghcGq3PZQg/VXiD2aUxW+qxCQu9lPhvVdspjQpzokHs6Qx5fAbfonzUWZSFs/Hi9pvSl6OUdVGwDk2Gau1v42178Vf8qNIqNa5AgMcImGAvOSj5es3LRfcctjaMiIizACQr5rpVW+pZq/YU/kzg7eUTnHKx5rzPoWE32p1Vvxvp/KQc7WOYlvSJ35q10zxIt2cgPlDApLwdnyxdaB+pT3Vu7TincV7cZiSkD6lOP3t4ebTxbQLxlnSWPDYoOEmLbnpItG0IW5YtdDCsAsMiJZlzIJZV0l2ejgtH5EiaBbgJOIrLpuCUzNjhcn782Xc3aW6ZeN98s/dNot4xdg6BN/Mh2P+js5j/vHpG5CJ9YblYiqvRZ59d2+tXumYJlgF7NDWo9TgTcw9aN8XU6m8tKSuw8HWhG5BKfvNk4WjNj/Y5KxoUT/Sp0ODuVD60zYNj6eX6TIzbT0/FJGMxxJ/mbvRZjT1Cx3fwHoSnToC8/aP9vSDqvoYFI2SnxV9aRLzrY7Flkr3MpIqhG6aqUxnaWnDjW2s93rnumhi1cGsG3gvgvXutiDX3uUFRhhM/rJ8cA0la2p9c+wKUDrM/a9sYcZ/vPN6WHFZ/G/hkmKv/TR19lqATrrHSUMN1dCh8ev7qT2BSZqJOeHDlviULTYrbHVF+VJpqQJXAE9F4LdJtEErG1RC4xhLJo/n2lTYp33QHwakkQcCUEvkbxTv3UcBZfR0mC8O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(376002)(136003)(396003)(5660300002)(4744005)(38100700002)(186003)(83380400001)(82960400001)(316002)(41300700001)(9686003)(6486002)(478600001)(6512007)(26005)(110136005)(54906003)(6506007)(8676002)(66556008)(4326008)(66476007)(8936002)(66946007)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MVMRBuBMXepqJh4iISqGuSrrFRywpHXSXzhJX/PYsUG7rN0S3PzRaWn6mmR?=
 =?us-ascii?Q?cjwbyB/cZI1uW5MA7fS7O7xv8YIdmQLU3TTcvdkLWalPD84fRMANwxPnJuNv?=
 =?us-ascii?Q?SJ0Xl8jbi1wUSKG/muSsXnThzYLY/n7sySf3rYrz9EOrIkljnTdOQ8juVedp?=
 =?us-ascii?Q?ezhoh3z4XvnUfBiKlPR8IZ6h7yDBfUh/5KaL873A5pCUoeR7bdsZ4wbnp/qD?=
 =?us-ascii?Q?4rB2yWtR0cZKgy1iv62SMuDCMED/KSHI5D8F+SOnY0hqUUnfLsDTo42qrJA1?=
 =?us-ascii?Q?R3aiy7/G/pKkL3uEAs3Oi3Bk6bY/2rPylDTHxOxwQ1YcHvsUVbh2vAnAQ9FT?=
 =?us-ascii?Q?4J7a1cf7fKnffSelB6AxQzIKLxRRrWLV1x5V6ZUoDJDrEt2XN9d+XGmrDn/G?=
 =?us-ascii?Q?5lcCMCpfC6sixxtAWj4hu7ITV5fBDvVVelbBznYa/V/qxmFqKRHDkoHrLsPp?=
 =?us-ascii?Q?5ffYTqcCyLWdliEZMK0LBkY5kufFRSomGjSrOQCIrD60Dey1MjsrAyv8FgRn?=
 =?us-ascii?Q?pHyg85XcyC0wadIxYipua38/iKDiXUQQVzEo28o09TjzhD5SWj/3IenxStms?=
 =?us-ascii?Q?kyCPONPlml0/zzhyBdNUx6hsqyFdlnXgmYpjX2UkfBRYYjQ0oz2mCKqg4EWs?=
 =?us-ascii?Q?9JSyaZz0vwS5GT2I6Ip+lXBmk71+HmNyCXsdVuSiUKcR2WzZfVoa/3TI7Bsb?=
 =?us-ascii?Q?cWvdx4aXogygEoOfw1617yBhLtxnagvnYrafleI6psd2IIo1fqvZc8cMwz+4?=
 =?us-ascii?Q?nQ4flYg50VHYiPmx7+3LCzgeKSEOmjjUF7pHDU8d4JwKk5sjIZHzSkdufo60?=
 =?us-ascii?Q?FndLAI6HMMagmZJP9CyRaBAwWK57MFAmQh/zQLwCdEJSPVhXat+dMqmDskDz?=
 =?us-ascii?Q?rIAy/zMzA64Mmq+VQGujiT8m1pzUN+1bqBwpLKzEHZMinnsb8pB2fkK8ziju?=
 =?us-ascii?Q?FPp5OxJbb2Uk5iPG1P6880SP/fhd1pwyuaGznNRMWEgVRPmBuretcsxyyKtI?=
 =?us-ascii?Q?l+rbZ+iAhUOMNSOooWB69ynHfVs81lGsADFpiNlukYji7WspSP5Jo+hRBMJz?=
 =?us-ascii?Q?Glbd+8llsgD5I3mWSRVuAtoFeAvM4YtnEZRtYtF3x9p0FBKhSPWMhMq9C9uc?=
 =?us-ascii?Q?98b/7W1/9b4TFWlZaQDt4ZHolmpyZHW5FgRKf3KVOGDZUqp7ZI2npxECyzvF?=
 =?us-ascii?Q?3DLiI4GsOylGqFj80mgAlbaaaUlO1o5UZfFymHjIMfjn86newH/P9B5VLUhP?=
 =?us-ascii?Q?okSV57bRFg5ETIjzGjCRExIk+6hrDWHH0tK0sWZ4tdanyGOOpnXRSPS1ds8y?=
 =?us-ascii?Q?JTf5qfhWZzdW4R0dhluj3z7eQOv2aXg5Rsyzrts3VtN5ZXL2krT2+V8a6OLF?=
 =?us-ascii?Q?RSW5OQGKaBRJAjX39Lp2JUjRuXpcVZ2QNN0JnDAp45V09p7s62XMiy3iy8Hq?=
 =?us-ascii?Q?vnN/gdWWb96J9hhTsJbPeSj0EpechbFaO5SPrcQJJ+r28jdc+Y3ramYlG2uZ?=
 =?us-ascii?Q?ykKQ8QCN7y6VwaF/73/HzfkV1DB3wgEIswoURu4By/wZ0oUSaMaEY1g3z9xG?=
 =?us-ascii?Q?fVmdv3284cU7IEXyk3wSxZSdRH4ZB1aTdnlcUoX2+Vcc5RtwdaIALwyr0x5z?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6719f6-af56-47f0-8db4-08da7fc9c0b8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 20:56:12.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inbczbTYop0PAqG0XmxLWKpP/z/y2tDw4bNzJdaZ4xh7+fFm9/PE32o1P7OD/mrzecqAa9R/5pXg+fN1ebtMy2036wC1T30+geoz2phtQOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3572
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Carpenter wrote:
> Unlock on this error path before returning.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/cxl/core/hdm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..873c07386064 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -605,6 +605,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  
>  		rc = cxlsd_set_targets(cxlsd, &targets);
>  		if (rc) {
> +			up_read(&cxl_dpa_rwsem);
>  			dev_dbg(&port->dev, "%s: target configuration error\n",
>  				dev_name(&cxld->dev));
>  			goto err;
> -- 
> 2.35.1
> 

Yup, looks good, thanks!
