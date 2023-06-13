Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C58EEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 22:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjFMWdV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbjFMWdH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 18:33:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1086719B1
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686695580; x=1718231580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uZ2jSqw123B27IBGERGtkwGe9YmQtEz6HW19yYR0zpI=;
  b=h1R9shJyLVmKtc1L8KY/B4hgN6lbJgEd0OfdCwhkQdeWRd8JQ/m0nq+D
   BOzUZtqUiwlDoOzkX/64WGy3PNzeOG5/afX3T7lzFyQv9JM0mvWvdLKyK
   fSm5LuS0h+u9FDAC0N96BTdQxETiFpamwF/6jAqBbIkmzzdfTpMP9Dkgi
   sOFLRC+M3fV1SRZWurMxlfGNfxaH5YlrlQ+OMOW8oKM/JPaPIuKCkLMGZ
   zcUv0f7Kf9p+2pFWwGQAK+oG7E14+s84beGvKM+BqHsfkw9WaZBfGfHFQ
   gNM9Ar/sErbx2SI2wcATcfh04HwjxzRvPkPJ6vyMprT8D0rfKYLj42tyw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338099111"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338099111"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="781865650"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="781865650"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2023 15:32:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:32:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:32:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 15:32:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 15:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epahFkB3Xrfu21hWi/jrj6oKSNTjR7eahBKnPfSrelfTa5QxsHMKNrYYVfZrbeNhB07FOHJrK5z+i6ETNs+PxsU3GfOtNFZ8bM6S2qMf5OiMV3qGq2KJaJqaCb+f5+jnAVKYijtQcmn0kYtdJ6ZNf18WdsjQeHN39TgEcm8OsZmc2eKnTZhUje+d+8xnFcC7hU6dBXxlr0qsU+diLkuhEUCmVMx+NFm0Vi7THbBIot1cukWfCs5P+k9RkD7XQWGLpZ66097ykxAO1ZeK45A8OBtk5j21vXUCv9M12dRfGGWNV4V4+irvA7nVqR0TPie0fmESfUx+cTgdEhYfj+y7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6ALlvz93CYWWvx98+Bxpr3npPaPwzLqStSzaLX6Zeo=;
 b=QNl6+a3e1Q3+0ENis80fjqE5Cw52TWxKXVcKNcTFOPvLBmc8RcKB1Z6gWlO53/UuQf1wTnq4C8w7WvB5mWrwwr0xgs8xdFanWc9wjJHgtH1cucUnY9pazv7Y1wYi0OwJBMG9JaHUlsdedhXN7l8Vy4Ox6dojpa9NiXTO3vPIZBSLQwPU+ORleOcAnArTne7wn3gBgF6/lcSArMKBoULzlxkuaOPW9Ihq0oiBKJqfLvDJtQv2uks26LrcGg+s0tSHHAMrGMb2a/NAXZmXmArI+419RJS1kozE1xhDb5ssC/qWNRBaPyHQsNyxup5shUupgE389jmgKCNYCJRvq4zDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5935.namprd11.prod.outlook.com (2603:10b6:303:18a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 22:32:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 22:32:56 +0000
Date:   Tue, 13 Jun 2023 15:32:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 06/19] cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to
 CXL_DECODER_DEVMEM
Message-ID: <6488ee96ed0c_e067a2948a@dwillia2-xfh.jf.intel.com.notmuch>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592153054.1948938.12344684637653088842.stgit@dwillia2-xfh.jf.intel.com>
 <20230606122723.0000093d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606122723.0000093d@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 308265ff-ec82-4c6f-8e22-08db6c5e224f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIuvltfO47r0SewDE+xBnDeX3akXnsUKrycCgc5ybTT2eHUzcnpyZiW0xOApz8MOhdRxUq/clYiBScdrzYCIvD2uHiwYDdssu+jhu259fcz+nafLhLiMWBhpm7biJyVEA8X23SGzytl3qRN0M0WurljPTlzuUAkbtTZ8E1T/P1cNFZ3kXqULRo7iERupfU9AVqUAVLJR7UOp6TO1YSY/3jH4KD8RLN8Sz0b5EByHr3bv9gbz7InWoba0jCIgi3yujv0o+c8si9v2CYKiPrDlhDbtTP6tnfXqrpDnIdG8o4dwAXMaAfdsRMiFymkYUk2jG4d5/kVbbTycmWWsGqTdrQp0uEw42i0oa7D3rpCN9m3wZSYoxwPCYQrSLtkzNzIQM/lvxJnJaIa7pWE6G3InfTTzYRc17OBYZahehoYEDnqcnkypNd6RgeIAQZ5XVzw3mdlBW7P6TTJVxyL/zes5sZ/dvbQYEgXjMeM0J58dbDmUfcNN58oWqWfPlU7wtXKT+fZ6PFqUyThztJxGOmP+vYIi2HVv4KAtBUZPthM+rAAx3OoNPKsGOMDy4vvz24R2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(66556008)(66476007)(66946007)(316002)(107886003)(4326008)(110136005)(478600001)(86362001)(9686003)(26005)(6506007)(83380400001)(6512007)(186003)(8936002)(8676002)(41300700001)(5660300002)(2906002)(6486002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h22pqqhGOg0XvbKCFH27oORKt2k3yl2JlTaLADPXT5ygnSCASNQgpCmJr52h?=
 =?us-ascii?Q?Vb3fTUMNDAg05U/rGpuLvqfGqF9PVoYVbvjfEk3PTERji1wuqDIz3GwGM1X2?=
 =?us-ascii?Q?TqzOaoqfqx9rBOjmzk6bdGsGe+4HnqcXmtk70vizKIclJdQKtmDKj5u/zfNR?=
 =?us-ascii?Q?Ey4G2NMGqDTUR+CtwxlKj7nNwcb5YJy82+SsrsyJxrzx466HDPewJ2UVtIgM?=
 =?us-ascii?Q?KuO0WUGWwon81lx32kZ18yQJLj3UMlxc4xdQFsHFzOVc0V3gzWmsd3tdD/jR?=
 =?us-ascii?Q?qXKzuywHfutFhlB0pZer721z85xD5zXDNeBaNq8/fK0EydUlumMbRTodkBhr?=
 =?us-ascii?Q?lYNSousuIfUAGZk9tcvG6krHebvieWn1LRfHiOBRgfDqHYy/FX6/E8fRliZj?=
 =?us-ascii?Q?jCT/ak7GT2S5BfyfeuMaVni7rMRiviHAMHKbQXJceXvWDB5ZK18nHqECn6xm?=
 =?us-ascii?Q?lrXVm18UxMnTN4Wyio/r6BRG9+Tmd2huja1kIeySdN6mCbAWtXFsUMHIIQV+?=
 =?us-ascii?Q?s++fisj5Y4MCpVDPhdooHOPAbU/uQYgK4dJVurYfeksrmEQyrFu+VjTj6yXq?=
 =?us-ascii?Q?wxaBDki2c1s5apxVejiqV3fHuDnoAqCW25vvbBDYaR139ZHkllkBbf1QWEHO?=
 =?us-ascii?Q?YLZJcT7boxS6xggXOZ/R+/zTBkKLzcC5vxd40Ruoy2T3LU+bveNfggLaxIht?=
 =?us-ascii?Q?QMgCGSXI0cqnfiIoiS5jwBeLLbWyk2xPIaucG6PaVCQOehEMgJE+LIv30e0e?=
 =?us-ascii?Q?BZWurHuMbo7vQOAhz4O5WVwRFjKT/XhsdWsi7fwG75Im0rBmggSOZAg/6Axd?=
 =?us-ascii?Q?PjBvYwf+bsZYsfGrKneEy6qRnX4Z4TWHvcOh5pAlB9SRGh8CgBg3c+ISnkxo?=
 =?us-ascii?Q?tlnhjUCBtXCAX7y+oP6VnK6NIm04UU3cwi6PXvf/kvR1eloYOqsyj2Hivt6t?=
 =?us-ascii?Q?v8inV01V7oodwQMhkatxDCde1PV+5sXhY64Ayxr45Cyxs3hhSu/QPcPM7rCF?=
 =?us-ascii?Q?gd7vAGhrmZ3Jccf9BapGpxlWsyU7wZs7g4qNwMu9kcRW+0yysPheaI/P9uYu?=
 =?us-ascii?Q?MJqh9fto9yBeVh6MrRmZ+xlpRfZApYgF969zhTcUVIoaCIhk0ZQkRb3to4MF?=
 =?us-ascii?Q?dbRtJtwCNwCfOiujneH2Qb78/7CAQLo9gN9FvodetjhLYyzdIjj3D42j2CDu?=
 =?us-ascii?Q?ElrtWRul92H/+c4vbr2uDU/vnKiaknA31MYf2o7W+0FAjpwXVueJwFuH+e4f?=
 =?us-ascii?Q?2nkATZungm50FETZmMiX4ZUp8w3t3TrazAd8wlxZT49LlTZeKvuiI1NCghjn?=
 =?us-ascii?Q?NYk+v1kGdMXvn5gtSIEFerSjrFknURnKoVKl/7NAJ6g9CSzStWltDWJDTK6P?=
 =?us-ascii?Q?NHiQXNFCssJUGhHc1uexkFn9z8of4PI859tWSDr7CTItTKlKFb5ZGkm/tV9z?=
 =?us-ascii?Q?hn1caiMDPPMhZFH7/OQ82Qpwdu5/lz2zFeier3Oev8UfJc7M9g0U4NT7/nBL?=
 =?us-ascii?Q?mIz8f5HmvbqR/XMbXWklyPxggjoYe7saUhS53u19+OJ0FfjUOfCUenIZPBmo?=
 =?us-ascii?Q?e2zycd80LkM32aS6t3j8TQu2vJEWZbdSOzRKXTau4pOMLpht6kIk2XakAex0?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 308265ff-ec82-4c6f-8e22-08db6c5e224f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:32:56.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nh+I7AMZlFSCdxLmUVHeEo14vuSnOgCqJzlUqvzficFbxCElOzbIBHxjCGAQ1qmOeuJSDYgB960dA3bwcP1giHzruvcQU/6K1iSTDAL1cDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5935
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 04 Jun 2023 16:32:10 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for device-memory region creation, arrange for decoders
> > of CXL_DEVTYPE_DEVMEM memdevs to default to CXL_DECODER_DEVMEM for their
> > target type.
> 
> Why?  CXL_DEVTYPE_DEVMEM might just be a non CLASS code compliant HDM-H
> only device.  I'd want those drivers to always set this explicitly.
> 
> 
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c |   14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index de8a3fb28331..ca3b99c6eacf 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -856,12 +856,22 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  		}
> >  		port->commit_end = cxld->id;
> >  	} else {
> > -		/* unless / until type-2 drivers arrive, assume type-3 */
> >  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
> >  			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
> >  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> 
> This is setting it to be HOSTMEM if it was previously DEVMEM and that
> makes it inconsistent with the state cached below.
> 
> Not sure why it was conditional in the first place - writing to existing value
> should have been safe and would be less code...

folded in the following...

-- >8 --
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 8deb362a7e44..715c1f103739 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -572,7 +572,7 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_TYPE);
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
 static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
@@ -840,7 +840,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
@@ -859,14 +859,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		}
 		port->commit_end = cxld->id;
 	} else {
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
-			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
-			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
-		}
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 			struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
+			/*
+			 * Default by devtype until a device arrives that needs
+			 * more precision.
+			 */
 			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
 				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 			else
@@ -875,6 +875,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			/* To be overridden by region type at commit time */
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		}
+
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) &&
+		    cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+			ctrl |= CXL_HDM_DECODER0_CTRL_HOSTONLY;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
+		}
 	}
 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
 			  &cxld->interleave_ways);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ae0965ac8c5a..f309b1387858 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -56,7 +56,7 @@
 #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
-#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
