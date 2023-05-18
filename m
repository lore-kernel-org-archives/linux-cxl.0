Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45BBC77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjERUjB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjERUiy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 16:38:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76D10CF
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684442333; x=1715978333;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8np4VGvOs2Xl6/KH5bJ0hvliIzutSifn/5HsjLSVEak=;
  b=arUw3LleVOURwRuGkGMJ6Q8uOHqJbWHhrahgqQIknDSmPUU6an5wC6LY
   jN6v9JNmmUiyCUWtwkzOEAo5pJcNF2AOSjbsh+GLFuSfNDr0HDw6BgWc3
   sRtEGma9pB466Ea/NFIcmyyPc67b6W1PJFvRKqfvUqPQtzDgSbZF+qz3w
   hLQFHML4LkPCKSAjagG8mW90rsopBhIntr0nML+BKsNSZmGQG0vyw3ONl
   XEANS8Je+3gngwiPDAX4TDXMWXBWLpYb46C3Ehn60pI0Ils7f1xir+xui
   r9kiu3MKB3X2dAs1+L7nGnpM7B12eLry27hU6sFVOmwyA1BaX8PRfXQh+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="417872961"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="417872961"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 13:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="948829189"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="948829189"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 18 May 2023 13:38:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 13:38:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 13:38:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 13:38:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 13:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc/RMrXdBQ1mOdmsMdWCHceaoOnaqv2eGRr/VxFIPnlxjN6Dw+HB7gMdDiqBqwPxLQLzSBbPBUEigs8HshjH0WRNEE+nD0NjJUFXeAEBpMxbHooodFDBjao1cqdnFnlukiWNYL6GoNC560OK2MpfBoRxb7q2VAcSl5G1JHWAcEbgjNKqs1bi9WSUhTUmivToMXnnVGgCrjpLkQng5m0uiGh/helJGuIRRGN92glAxoesvhNZuCkpZnhs4xdx4m+uwMUR7V7Z66Xsmc2IKq2xTXYnDU8s5XobfRThcj6+FH9OLk4zeDDJlgkUkJC/dQnKm3LSouHW8/JizTZU8xGPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P6wCu4RolyKXDSLOp5noMgS8lpTEvTCkoJR9Hf4Mzc=;
 b=aXXpxfKXU4j6/c2G+MFP8DoRksFj1l1j1I9rd+mf8czlq28+u1gSORQRmQ9FAVpRDgoky1bPHRTOhXTJwY87Ni18pHom4bu8Sk2pAC3OK0OFl8smjJAlRhEfzhJHcVT+nusqS/OinNS6cMbT54xteuuhTdU0gEY88Xp3L6N5RKlvD27P1FKP5r2xeNJFS0uv7voBTwBHqmD51z3GC2CICe/K2wtf5DwsE1gGG2EOrokNLcXE52YtykwFAi/3d4afnQy6NTDo4s7Nd32r0gmfGQFBL+f9KXZnlGAnsE1aD2vfJklbJB8z4BdxmGYXIkF9Ggci59PhDokC+F1+X0W+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Thu, 18 May 2023 20:38:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 20:38:40 +0000
Date:   Thu, 18 May 2023 13:38:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 2/2] cxl: Move cxl_await_media_ready() to before
 capacity info retrieval
Message-ID: <64668ccd4280_682c129483@dwillia2-xfh.jf.intel.com.notmuch>
References: <168443095459.2957452.1648087475761987955.stgit@djiang5-mobl3>
 <168443110845.2957452.15022248373553807511.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168443110845.2957452.15022248373553807511.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0eda5b-e171-4d0e-ba86-08db57dfdc9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLEjCNlc/QbRh40eQBVXybDTh+oiO064+O4VUb48TlAHNOEtQwqFKBNEe4WTHrOyOyx1qQR2kmDf2GAiGWgANDOmUNCCzam/A1QvhP56NAWubkfoDdtjy/XlA9hPxPrZjRa5sLy+OOuyAxg7LVLSmaIWJiIymCASoFYUyBAcPuX8oJxNZCGarnDG5yb0mtDNwBLUtsfS/7dnb8hclPQOtbtu1EJ/61bx5fEJSaF5nK/h6qAuPsvWYOZICFOtRdgI3PNmnbVA0Ndgr5X65ZPKW/gjZqvOJbr97gRoh1UhJSnXFFaO7rJCAHy221/7c3MiVz0jBGyOT307asFMJPbnzOvJCsf+S2Lhoxyh4DboaDXXuz/DO18R6QhHq+3750b/MRcBkmCCI92Fqt0H9ZoKwCgknDxBWMXYTMuiD/bv0JUArPewo7ju2BQ1WCnFFFMXOwdTTaxAI6Dzmvnc8wq3ZAZjyOGVIgpVJzJdKrGNK33/+jMS1mZWi5VsQkjvfDjT1tc3pAfvA42Eaj9mejUpmVIRugJjUTNs+/2Q0jnUFKNx0p7RIMe+uHgHKrmxXqCn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(86362001)(83380400001)(82960400001)(41300700001)(38100700002)(5660300002)(8676002)(316002)(66476007)(66556008)(66946007)(2906002)(4326008)(186003)(6506007)(6512007)(9686003)(26005)(8936002)(6486002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKTeafrgXh0HuaucrLCuBPIce1FvV35/5nm3MiGinHUPUZe+dttgJxPueVAr?=
 =?us-ascii?Q?60rOv5Xc2BJNm/finJPUAUgcCgRuBGJZ/yKrgvxEF0dRGcZWJqJXbdHAcbQe?=
 =?us-ascii?Q?0Eu4PbtnytZqDzstpWVgo8hojVwSZenjhSBzmWDyfkBrKU15KHd8eK8d3aZi?=
 =?us-ascii?Q?DwMbLYTS3dhDviqbKsioJWJ2XI5LrBPzT8AAeaKflRRygPIU9rZXhpSOeRdk?=
 =?us-ascii?Q?1yr8sDl6mCnaX8AvETjXpIT/L+fBRqUx+AgLzGVaUxLy1ro8gSh9HmeFJ7fw?=
 =?us-ascii?Q?s2/S7GMsBuUn2D9E0mfwyh3Kk/V3HgrESubgEQWqujAbtH0GptY0yuF81hcL?=
 =?us-ascii?Q?yl7b1x5vEroxNaGKYFgZbnO9Ywyijo5iCl8xQslRZBepParm8iVPW9xWgu26?=
 =?us-ascii?Q?pYoCtpxfe84zRfswz8FkGU8DGduxODUdyImyVTLyqop6wtJCbX8sPmwWpjrw?=
 =?us-ascii?Q?owe1dqEDq5amlyN/GaGVE/QC/7CdX/ADcZRKoAGDzzdigg9EZ1D9nyExELz8?=
 =?us-ascii?Q?yUrMUf35so7CK85TByApWYgY+9RRWGQrWcd81UROg/G8CM6qDfzcfNVwg7i4?=
 =?us-ascii?Q?O3Rt9+SwmYD1Kh6ayYcwMGVEIrMdA5TvfHi7UbQcrGawHost9ZTUA1tZ1UzT?=
 =?us-ascii?Q?TYehuwAiZ3kjzKAFc/9ZTrHOVCnetBHwxx6izd5J6FUfLNgKmq0nsMOgTw2H?=
 =?us-ascii?Q?+Za6CXei9nmNgQkSwsZVAhNcAbx4EW8m/o/7BEasrY3N2mYtaxgI7S8I/Fg4?=
 =?us-ascii?Q?br3mcrXdJ+pPLOYblUMXrFq7J4PqvrP6MLLh0gtDhiCZoDAFKTqO3Ro4V1p3?=
 =?us-ascii?Q?EHFt/kFY2Vift+DgXPS6Es14dlNLymwjrXGdAh61iEyZtytYJJKGeA1M7XQM?=
 =?us-ascii?Q?/4zX0YvWHANp8MCj9e2SP3KtmbiCNIHYU4kD9fPa4/sq/oOyXRWmyuSXFnN5?=
 =?us-ascii?Q?eV0WvfvxNkrVUEUzMft9Dm6BfoqPRbodKOL6RyO0HK8+NlkjBWu9kKNKAYSj?=
 =?us-ascii?Q?lJ3KcudyJg8KX5eosCMbJlSSxlgdhI1hoHaC0oVgaVvUUek/HLz3rYuALA/k?=
 =?us-ascii?Q?Xyrapcf1aUaAG80kuuEqQAfMnG9ciwh91Ukr+fmV+mq2ES8p8aEpVf3Wm23w?=
 =?us-ascii?Q?3U5RQoZNVLNdOPRdmhut/JtT5FEQzRT5R+gx23LL5h1vY0pG7l4hA24obeuV?=
 =?us-ascii?Q?RqNGSZ546pEaEhc1ZYtT9k1LzWw2zs6jFsrz3/W/+d97p7n1I5SNG1mgtTkO?=
 =?us-ascii?Q?LeMXoJQAuW5Q5z1SoNLRCSChfjpUggG+Xf/FURlH+5LYjcnGEneSGCZGlFR9?=
 =?us-ascii?Q?cehnBN8En+IVo0Mls5tm+BkdBxEsQYS91TQPNq1WFn2HLanrl+QrrTKPCLUr?=
 =?us-ascii?Q?eLV2VXmtwaYKYLl9VEOGOWCBAJY2A6Bhm2bgejoT59D7kaq8LGhjzItLWQP9?=
 =?us-ascii?Q?+tk7kI3PwTTf+hmIkQoUXZuF1THhHax1INIzWYNnG5wgtUm0frb+SiKQyP+v?=
 =?us-ascii?Q?64Kpv+HLC/5p/lvdPKbW/cxkA92x+6+7w8PnpiyfR3AUJVi71baeb56pU3A6?=
 =?us-ascii?Q?4DaF49WjSgJ3+4N2ifNixRTFa2IJ9qoAtinsKrhFPRBIQEoWYndbQI9iFcMu?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0eda5b-e171-4d0e-ba86-08db57dfdc9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:38:39.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0ukfj/0QG2O8mpY3wU0O8+wZK3uSUAwNfJ7DfAlXaeEvLJ5QIqPeC6sOnXfqBXHVoIyBCARuDyOgfaVdGyHHbP1I3n4sXjZJ+AkWo5uhJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5608
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Move cxl_await_media_ready() to cxl_pci probe before driver starts issuing
> IDENTIFY and retrieving memory device information to ensure that the
> device is ready to provide the information.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c  |    6 ++++++
>  drivers/cxl/port.c |    6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ea38bd49b0cf..fc59ca79b2a0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -708,6 +708,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	rc = cxl_await_media_ready(cxlds);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Media not active (%d)\n", rc);
> +		return rc;
> +	}

So, now that I see this new failure mode here it raises another concern.
I think there is value in still trying to bring up the mailbox interface
even if media-ready never completes. For example, what if you need to
update-firmware to remediate the device?

The mailbox interface does not need the memdev to attach to the cxl_mem
driver to enable command submission, but the question becomes what do
you do once you have fixed up whatever condition caused the media to
fail?

I think the simplest answer is to just require tooling to reload cxl_pci
for that device to re-attempt init. A more complicated answer would be
to teach cxl_mem how to revalidate capacity after-the-fact, but at this
point I think the implementation is stuck with cxl_pci owning capacity
initialization.

So I think this looks like caching the the media-ready timeout condition
and teaching all subsequent code that cares about capacity info to fail
and continue. Like don't issue identify, make sure the sysfs capacity
values return 0, and don't let cxl_mem proceed with topology
enumeration.
