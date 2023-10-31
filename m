Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7E1DFE5;
	Tue, 31 Oct 2023 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bachFozK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E712319F;
	Tue, 31 Oct 2023 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698787059; x=1730323059;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ptzA/UT8lmC3BkkGzqSSexedkZ/HS2wWGukzslYbUKQ=;
  b=bachFozKAEgYwL36L0M0oCDKwR3FyA9QyA5X8ngUIcBTVGxq+QXXwjuT
   GyoFC6ZwxBOlXUWBeXhAUKSEYn7Q07FZWnbuajERUysMXP2cqJDp22ghQ
   6oqQXQAJoqDSgQ/8O+mrXzt45Z6mcWZ8nU0m2KHbkEmdLS/6Gv48jlS/f
   BcNyo9ObLEdi9qK+80MN9dFiaQ2e0rxzaCzDgaCm4YEV8fRereKUFxfgO
   9+ucm3y2fveGAeZQkQn+JzXgB+FESpxDcVUTxpXl6lSocH650YNBhSjWL
   TeBsV4a9USIyK8dLkwXBCD/cuym5M7CdLyXtR00bJdrtyoIRvw/D2ArMy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387258997"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="387258997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 14:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="710563900"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="710563900"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 14:17:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 14:17:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 14:17:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 14:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBBVJuee9Yxqd4+TIVG8CSTfiLrfDIZtI+cRyRRKEFIpQ7tWd1A5wb5ddSltUbSHznVGvBB6eLFPLYTSjG33tIQXA4iaIlSPf8XqHZNw6Lt/mTMjjdiLx4ROHH3KNBR+1CxQ3o1xcgRC9kRsP/3dkeZlKCM+qpEeTG0+KbjSrnDBTQyQPXBNCJTjTbxsaHPovYtyNcFeblhmM8idB701BenrSCZS1FcuV/eKBlmqBpEqkb33UXBetgOg5uPEGefZub8gqHcN9hXmwJSa16WPj0R7AFoTqoEfdZE9w3FCqLpDUX7EdT8DyBVvpMEJxM+AEmHDXYFaFlahqOk5/L595w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4Mck8fkq3WhXwpXkXeYCnmYYIxpkEz+SB0c9x27BRU=;
 b=G+CIVDa+yGxX+lAe1NkOObvDookLg9DpFSF6MZ+7n2oJ/QT8jXYVdXhpdxgIxh+U1m1ARlmunOqybYyj9oc/IHXrttoqlOSSnZ4qzEF2D7nuASC2dDNi6AWMooLmokDKfnbrmb38I89JqDYCDX1CW9zMYn3+FHy0goKTgASlOny/3rmscqCQAKJZdP8SJgVqD6DI+N8qp+OM0JE14un+qgFnz//78Aq5uUa5aXKZLJpZCybXCHJ92QuFfx+436UlquFodWzp7MxOl80JenHfWIQLKaMzrw6I2PXadDzzVa6VIMIEBlXxVj6U/FlZshEI2v7BUAE17CKiia4RxlBcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8037.namprd11.prod.outlook.com (2603:10b6:510:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 21:17:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 21:17:34 +0000
Date: Tue, 31 Oct 2023 14:17:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 2/2] cxl/hdm: add unlock on error path
Message-ID: <65416eecf55b_780ef29464@dwillia2-xfh.jf.intel.com.notmuch>
References: <60028378-d3d5-4d6d-90fd-f915f061e731@moroto.mountain>
 <63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain>
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc2908e-a5d2-4907-9a3f-08dbda56ccf8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOZ8SxdEq/KwO0CNlNHShgAAhsph+kd0Dm2epITejOlNs9vzqHFsoq3rcp0wAIUn5KmGpfTv52FTHIaQJSjCmPjd5i2Bxhod0DLxWADwtUtLqVXGG/mKiyo4HnKLYqfBufzCo3XPgHBDZgrbYNapvu0FshY3RNCmJaxZtwN8ysi1ISp0sf2jI0yndyw8iwBXwvoD+ftShbuXVrmQyGDkhUIuEgyUgJ7sB7dRdI1Fl1UJsS5NBj7XTZlkgyCWvtlawe0LUFyjW1JcT6mhJbQRAZlzqP3r0tPKaNZ38MuqkKdga3PYikywPsi+Vwana8Kn8CXZEOJp/1dy0X5yhlJYSc7U3UCvUWB9F3ZF9lZVXyC6KNUragWVjtQLalBaiDoP7e9MNgSkNs7ZX72Au8KlxdF5FSDTqetMpnApnj43p/coCXYEQX0tIX/p0wVn9TzfVTlbVMtbo/opAqGxYxZbRASg1Dmm7rtcU/OHY3oErWkdgcw+jajF37DLef7+6AOySfQV/4QN/WOvWFVBaAN2RSWS3eHlmDYrlYzhiyvkTKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66946007)(82960400001)(26005)(66556008)(66476007)(54906003)(110136005)(5660300002)(83380400001)(8936002)(4326008)(38100700002)(316002)(8676002)(41300700001)(966005)(9686003)(478600001)(6486002)(6506007)(2906002)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+4e6XEBA1gRzMxEtnME0aSl5UVnvpIFOl4PGl235VvnD/E68xi5SbP7LnEtq?=
 =?us-ascii?Q?BnFrnK740N/P3dA598Bx/T8/olLMjrKyQPFbRBQH3O0lAHfpAtH19cWU01z3?=
 =?us-ascii?Q?4XYMm0nCF8xDTbfKNL4hzwQMoPScbbFai9oswMBcaZmC8H3GmClCBSKt9tAB?=
 =?us-ascii?Q?v1r6Jei6xehamEXOkMhdOjzZ+qHmfiOIYCWVAlRF2maiCFCsUHnnewt7Zdh1?=
 =?us-ascii?Q?xvFwisI3M9tMPu7k+22Jprh9ydQSQOI9KwsxwnmQitvCMIuAW/Dq8tQLNneF?=
 =?us-ascii?Q?NXns0yv60GVPGfLwPZVvAVwb7m4Gdvd5sEGRz3/vCByZgBshFwySVPdMTvQv?=
 =?us-ascii?Q?V0akC6N5K1nhH9rqFc57Pb28V3RF9Otw4kIJ9Mkun4alsHVqjtGh2gRHrruK?=
 =?us-ascii?Q?dqTguWF7fudxl7zEyt4bu6OvSMtQBfqK2Thj4QQsRS+ZbJBhEiNTRROjv4eU?=
 =?us-ascii?Q?nTlmYLmGomREMxqQ1ZzLVV7JWwXD72TmraOyb7GpPKuHevAo+l3fAJm59lef?=
 =?us-ascii?Q?KVbaZVaHvPOjCfhAgVtFWgQ8CG8fu/Mtqth4ZpHUKFfNchTWtsr/AgCVEOnP?=
 =?us-ascii?Q?C9joyVL7XtItnpkjht2lLTnibrDQMWrH75JgxjTA/VJGK05pJQ5PcJgGmGnc?=
 =?us-ascii?Q?N/OloVB2K2norQSZ3ljw/7C7ufQSGDi2AcwfG/OOq5I1z3U7AlYynVGqv2yo?=
 =?us-ascii?Q?W3y7inPGi8URzzrDanJ1f44PKVw0vcg7Qk0/cByg4Nzeyg1+8HkwryeYSWEi?=
 =?us-ascii?Q?aaklZuM2qNwQOUPVhWkV7ylZL7CHsrK+PYH71PQNxaG+QKnUfwurDrfyWVZz?=
 =?us-ascii?Q?H9anCsG04cOBmGm91ONiJpQEqFupNPGKqMbpv6n7pkdDpJPnsCJA7dc6962G?=
 =?us-ascii?Q?ktaXoQjxvTYlyOAcdFbENNSTW2rFuS2dhNReFx5e2WcqJPNHmJFcd4pH6Bxj?=
 =?us-ascii?Q?n7QDFCPwgxpvxvBnsmrE3wxG7d47kc2iR3tUpd5/cTacDWIEN8iuJNfep3bN?=
 =?us-ascii?Q?wYew68f6XqQSpeIKCkSkR4tlt8NWekxOLcJajKGi7in402+38EViHnY6lo/N?=
 =?us-ascii?Q?gl4Zht0CIJwvZGM00czyDptyGqMvQeJim/9H9FL8Yc14zJIhB3SaRHFlKB6o?=
 =?us-ascii?Q?w9MXgolK/Wd1NmUZIkJXQHmHw1TWGvoht1mepg3ipOsNUz1xlfFzPWOoT3kV?=
 =?us-ascii?Q?mcuGdNg0viVCPLT/pkCECrRI1QcvGBzX1ulRq33QPaI6rNUlW6BndbxzmWNp?=
 =?us-ascii?Q?SpI0sm0rcm7J33esfqiSN4G2OcVsrqHsvyIeA2hUGKnK0e63u7U/cu9GGerk?=
 =?us-ascii?Q?Z5yzzOEjDklY2JTncrIQJoRbuKHsGuoAleazkMy0aLcU7La3bA73mKO5YwFr?=
 =?us-ascii?Q?BOIPPy/ziuAZZVm09klj72iSc49o7+SsVt0UpNywj+nAsIPfiR886nI8QzAc?=
 =?us-ascii?Q?MkLzAdSTAb92PnDt+5r4LqoACx9ICQpnhz2yj9JD9DZ8yU+ucU4FuWxeBr5c?=
 =?us-ascii?Q?aIkT1UK7p89vlVjvMvYOgR2Z7ySpsdmGwH7R41bAiqpdSMhnxMSHzTEDZQ9G?=
 =?us-ascii?Q?Mhrc+/ZgcmVZNahIjhUejg3InTzUKcC+wYU9WRPD0b3xByKg3sZiwnSqj980?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc2908e-a5d2-4907-9a3f-08dbda56ccf8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 21:17:34.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Im4KGHMrvDNTOmHA8qObRSua027n2WpuJbPRbU0mGpLsCLFuR85R+WxUkDV9eKe9uaU3uIpnWOfhmlAgRRfWUS+bUtZkEnQVHjOfAUa5Tbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8037
X-OriginatorOrg: intel.com

Dan Carpenter wrote:
> This error path needs to call up_read(&cxl_dpa_rwsem).

This looks correct for what it is, but that error path is a "should
never happen" situation. It would be better to just eliminate that
possibility altogether...

-- >8 --
Subject: cxl/hdm: Remove broken error path

From: Dan Williams <dan.j.williams@intel.com>

Dan reports that cxl_decoder_commit() potentially leaks a hold of
cxl_dpa_rwsem. The potential error case is a "should" not happen
scenario, turn it into a "can not" happen scenario by adding the error
check to cxl_port_setup_targets() where other setting validation occurs.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: http://lore.kernel.org/r/63295673-5d63-4919-b851-3b06d48734c0@moroto.mountain
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c    |   19 ++-----------------
 drivers/cxl/core/region.c |    8 ++++++++
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index af17da8230d5..1cc9be85ba4c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -565,17 +565,11 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
-static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
 	int ways = cxlsd->cxld.interleave_ways;
 
-	if (dev_WARN_ONCE(&cxlsd->cxld.dev,
-			  ways > 8 || ways > cxlsd->nr_targets,
-			  "ways: %d overflows targets: %d\n", ways,
-			  cxlsd->nr_targets))
-		return -ENXIO;
-
 	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
 	if (ways > 1)
 		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
@@ -591,8 +585,6 @@ static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
 	if (ways > 7)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
-
-	return 0;
 }
 
 /*
@@ -680,13 +672,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
 		u64 targets;
 
-		rc = cxlsd_set_targets(cxlsd, &targets);
-		if (rc) {
-			dev_dbg(&port->dev, "%s: target configuration error\n",
-				dev_name(&cxld->dev));
-			goto err;
-		}
-
+		cxlsd_set_targets(cxlsd, &targets);
 		writel(upper_32_bits(targets), tl_hi);
 		writel(lower_32_bits(targets), tl_lo);
 	} else {
@@ -704,7 +690,6 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 
 	port->commit_end++;
 	rc = cxld_await_commit(hdm, cxld->id);
-err:
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8d3580a0db53..56e575c79bb4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1196,6 +1196,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	if (iw > 8 || iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
