Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAFBEB64D9
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 00:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjFPAHM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 20:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjFPAHL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 20:07:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A2618D
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686874030; x=1718410030;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=qcHvFmOUgYOyaOoMxFGkaNd3d8Ac2Mi1TC4ALaHMh0M=;
  b=KfzFkIIO1zKrsf0fp0jr1lqODIVjX7Q5R57hlinzbZoyxmuKyZvhUrJD
   jo0+hrLZ2opsyHV8Mcx3EefEE5iC/p0g9YVECJAcPIHlK2ml5Xt707Hhs
   8Z6QHm+ne0YQ5K2MojFezrcIKD3ShgiGKN23XYSN68XK7zaRfiOAhi+ET
   pUEDjeYwKvi+Ns/e8Ku79kYW2nSjSeacHlaYxHrtHXwYRdWC/vfZ/TOOw
   HrgDq64fx7qd0SFSQL1vlUCeMveX9fcuSvJqGOf8iOOdxRlt8GqXMzhSM
   igORO/xZV7/nPcbHszxgzVpaGRGcF1mt/078UCMou5Rf2Ra9P0C3/Nz9Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343812761"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343812761"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 17:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="712650872"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="712650872"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2023 17:07:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 17:07:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 17:07:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 17:07:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 17:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aecDekip/OjeNPSfC9qk3lg1LXSzS4fnJ0p88VvuAIk4+oHVOwDAOmPwRdYd7V0TPYp0dhNwmvPH9KmdE7XirypAplnwUEr5iyi1+Blz1P1fZ+xqqW+eeOhYJEsMtvY2Av0xK9xTgD4QEEtUmeqpApVTGdY9WJwH+fUjVGDEOFh+PvN3yobOKyOKBr0/ennm90Q8fUYAuq2uqd3Kdjz9Nin8Luc8WfSZpsFWrCGcZYdE000xvLUXXHewsnGNI4t4o5bwnxWyrPQ98DilheapA7DpH5QqhoqdF57zJyUD/pSbE84dKptjjmOleGWja8iuWyjO8bS9fByem4KZ7f2MnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYDLWYl6cWlx23pRBIAXTXwxGrAq1CyfxzioAeRXv10=;
 b=QDbKD1kPwRApVOagoyW6MR+FXeJwHt9JXUIx4O7s0639OF6ey5eT9Ay1ZgH9IY88HBBVhWg0Jdbj7hd71NLld1VUCcVgZJYYX8PEKvy3N/kZGg863DCrfeu7V5GZJRb06NDYzh25ji1WLFT4FCk48sRom5YJWvjoMgF6FNjvnX1FmcTWpIaTGrcpLOKz1gR5cfJvcYpPNe5UknJG3cLiA+2h2GdjdJNos5+05FjAewJwyXmY6VdbgVWcyVSjTCqQCPE4CNgEZZDL+VLbGYypSdHWzvzXjBr4cCVTSdJ750znh6V4omeImmNMwXA3PVvXoeWCxby7Hy6PlrFlw3Esug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Fri, 16 Jun
 2023 00:07:06 +0000
Received: from BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::e527:9093:f7ea:d514]) by BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::e527:9093:f7ea:d514%5]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 00:07:06 +0000
Date:   Thu, 15 Jun 2023 17:07:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 11/12] cxl/port: Enumerate cxl link capabilities
Message-ID: <648ba7a78f549_142af8294c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679263707.3436160.10946564604121831708.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168679263707.3436160.10946564604121831708.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To BY1PR11MB8127.namprd11.prod.outlook.com
 (2603:10b6:a03:531::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8127:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d829de-d2c2-45e6-6e45-08db6dfd9ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJ8yY8A+58qaDP1LFOogKf3MudrFdCtQXqsyNrJAHeHqUa/TAhWNOYKR9+4xq+nTRUxl2QTiqMyQ67CqxqinwJwmBeGrX6gd/PKMyICezT4mPrFXMOzmAFd4kXBP2QzSOO94S/mTMuZDGBnB1DMiFVUexMxCrbfMpKELvqMYvyGzV/PMFd88OuPu8CpGD96NGIGsob+H56/dLRM0LrNaMGfpgb9pmCauFylPm9RJuqmD0Ilhq+zZqHFtyUvjMOPM3k8DWGciRIUlwykp2LEDtqp8MSSRRqVFQ1wPsO88xdKmX3FetlILWmqaV5AZNN1udQEhzgpSXscSEIlrfqSa1QdqVc2ky9Nu2wmjR9GbeRTQ2apdr3SmwFdNM4NseWuWRGRDAP7dp8/kUd7uMRJ+KusltsPadYzKXsmDlj4RmC01iGxBxtkA/xU65ITXmuTJHeIlo6rDnYWE7k2E339Z1OeJyV1oWhf6JUhU61EclGJsqxejb3pztDtZTyo5j8aq81A+pNG7rPcYCW9o2g6vtqTi65apuRVrU4xAtXAbUISWSg8cp8x0P6RAv1uZj/nq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR11MB8127.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(5660300002)(8676002)(2906002)(8936002)(66946007)(66556008)(66476007)(41300700001)(6666004)(6486002)(6512007)(6506007)(26005)(9686003)(316002)(186003)(82960400001)(83380400001)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7XVhlePk/YTpk8QfBPdtwBFmcrjL14CS3eFlIuvWNPBMIwVvnu70a99gDXR5?=
 =?us-ascii?Q?igVmOyYaCUBddJXfySDBM9HtsHAez+6/Fyys1JU9o1IC8liVbxY5A3bgtb3k?=
 =?us-ascii?Q?eCQUHmDOjoF2/DcjQXGY/jATj16Fg/EDBrQyzUijpE4DqMf74om9ktDYSqj7?=
 =?us-ascii?Q?Ns+PP59ix969U3B2ZWkN4PPDc1Zq0XRf3V2SGs2WyrR8b6GpDj+zrHBt76id?=
 =?us-ascii?Q?udS4WsGboo327jwzvkxayYKrCuvf6+0Z4SETa7hpr/n14+YNZctPxfg5PdaH?=
 =?us-ascii?Q?mhg3fzx3Z2H+gwHIFZkvq/z645/hNMaMhBWr28DpPypbu+X0yuDBdp9zbcX9?=
 =?us-ascii?Q?2PoLtMAyzi14/+8LSESdxzlJNZcKJ+G2xLtsotxjLVsYdyEBzGtxZBaa9Dny?=
 =?us-ascii?Q?qsj5A/KSjQu4b/rnLCj2PWV6t4k4gin7OHMX4wmynuI0WUQFMP5qljwmO2sq?=
 =?us-ascii?Q?4kiPkMg9/WVxZf6x0w+E8RdW8cCrrJn3/W6DCp0Q2wfyolQYIPzjhnGaMpy7?=
 =?us-ascii?Q?KBSzjLuOB5HMHJfc/ELeO/k4mT3W0TEbS2RGfq4LZiaTsKO/y91i4A/oVwKd?=
 =?us-ascii?Q?Hq29zQw0YE5uaRUGpqbtVA4ZB+9/fHadlR8PUQtc/m/aLf4G9zcgVVJEaHh6?=
 =?us-ascii?Q?LiwlcPsk27eOWvVsk6VOEkh40Ff6apb5B7wZchYChZhh+R95+YFwdX9GVF2Y?=
 =?us-ascii?Q?FQVJXu+xmeQlOpd/ex+3JCivzYHDwYyPwHKDILOLE1aa8kFOoVJE7au18Cld?=
 =?us-ascii?Q?39MArVgwHDlLRNrf84UKRuw5W1N8f4Boh5rwEQ5TRZ2cKuhJavfu6ivpHPQy?=
 =?us-ascii?Q?pvpy78ZlcOt92XUnOriSftydIyxRFTlqpQOm8dyW8SV41RvFnJm/cVQOS1OQ?=
 =?us-ascii?Q?ypl+rwHblv/eHqUaJ2jnhHhYfQtBAXfH0VP1gpk2X1fEKBLYzth4nDs61p/9?=
 =?us-ascii?Q?Zk0zihU1Fd/MsjS6wlV+PFYZZKBizuhAVbQBLzDFgrtPMXhsKUIkJymSWJwx?=
 =?us-ascii?Q?17Ali0SiiH/JkAJ8kFk0317eE3Ml4nwDV/gpni76BBEPY2a4K+9k9KiKs24r?=
 =?us-ascii?Q?fzmb23hrheZNitWGbdBW+W151SG6pXUxao4hZaxdDg4jDJ5wMDlfZFRvYVWW?=
 =?us-ascii?Q?hcL1SqBKrvNA88kJ46LBjlZi1oXOuiLdczpTcxh+xkiycxiQhfmohv2+sMd3?=
 =?us-ascii?Q?eiSmtgAe6pvpfXHjb1KAqf6iE7n0yq0eK7ZC2Nw10iw2HlUXeMUiHPBmfPBn?=
 =?us-ascii?Q?f4mrVE8dVlLi2AiO99mjzrV6xunPkCIfWZAmpjISPPRzGuNIBjkKPKQpgskz?=
 =?us-ascii?Q?1ljX5rcirX32ay8EbpchktT9CCoxpt+s123iVpz1QDm8U1zNY/G48vqN5IKA?=
 =?us-ascii?Q?xn6avPJZaTJaVRdmPsxluhEJ5Ok4jtlQrih5dDVlp9d7k4IBdRnKzJ+KOJcJ?=
 =?us-ascii?Q?/o9l4od1UihXy1tJwJQCqHG4B0IfHMMHTEO1Xh4teQ14bC/S1/oZd5bcIYrt?=
 =?us-ascii?Q?I5q8HBHmpcRDICPhubXpwmiKxTtLecq0neOy9uo9hzux18olnFaURq3H998i?=
 =?us-ascii?Q?4jjE9okTi8hgeWybKwhVmrFW1DWuh+ga3pnQg0Os/CN8BzD7kUdHfdFcS0Hz?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d829de-d2c2-45e6-6e45-08db6dfd9ea2
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8127.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 00:07:06.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLgSf9S3B6KJYSfbK5eNDROVKZlocK5A9bRxJ4m28QmglQa7+8EAvYZb5/hPKav1cqMcgCpUXwFsOnIY0ctq7Od4JC5v5gt2jRJaPAgZJiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Per CXL 3.0 9.14 "Back-Invalidation Configuration", in order to enable
> an HDM-DB range (CXL.mem region with device initiated back-invalidation
> support), all ports in the path between the endpoint and the host bridge
> must be in 256-bit flit-mode.
> 
> Even for typical Type-3 class devices it is useful to enumerate link
> capabilities through the topology for debug purposes.
> 
> See CXL 3.0 Table-64 "256B Flit Mode vs. 68B Flit Mode Operation", for
> how to determine 64B vs 256B Flit mode operation.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/pci.c  |  113 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |    6 ++
>  drivers/cxl/cxl.h       |    7 +++
>  drivers/cxl/cxlpci.h    |   24 +++++++++-
>  drivers/cxl/port.c      |    5 ++
>  5 files changed, 153 insertions(+), 2 deletions(-)

Going back over this again I noticed that it fails to actually store the
"features" in the port object, and it fails to claim that the root CXL
device can support all the capabilities. Here are those fixups to fold
in:

-- >8 --
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7440f84be6c8..659da6cada6c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -555,10 +555,8 @@ int cxl_probe_link(struct cxl_port *port)
 	dev = &pdev->dev;
 	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 					  CXL_DVSEC_FLEXBUS_PORT);
-	if (!dvsec) {
-		dev_err(dev, "Failed to enumerate port capabilities\n");
+	if (!dvsec)
 		return -ENXIO;
-	}
 
 	/*
 	 * Cache the link features for future determination of 256B Flit
@@ -617,7 +615,7 @@ int cxl_probe_link(struct cxl_port *port)
 	/* Enforce port features are plumbed through to the host bridge */
 	features &= parent_features;
 
-	dev_dbg(dev, "features:%s%s%s%s%s%s%s%s%s\n",
+	dev_dbg(&port->dev, "%s: features:%s%s%s%s%s%s%s%s%s\n", dev_name(dev),
 		features & CXL_DVSEC_FLEXBUS_CACHE_ENABLED ? " cache" : "",
 		features & CXL_DVSEC_FLEXBUS_IO_ENABLED ? " io" : "",
 		features & CXL_DVSEC_FLEXBUS_MEM_ENABLED ? " mem" : "",
@@ -628,6 +626,8 @@ int cxl_probe_link(struct cxl_port *port)
 		features & CXL_PORT_FEATURE_FLIT68 ? " flit68" : "",
 		features & CXL_PORT_FEATURE_FLIT256 ? " flit256" : "");
 
+	port->features = features;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_link, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bf8f25063914..05ec8c6e8a6d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -670,7 +670,8 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	 * cxl_probe_link() will fix this up later in cxl_probe_link() for all
 	 * other ports.
 	 */
-	port->features = CXL_DVSEC_FLEXBUS_ENABLE_MASK;
+	port->features = CXL_DVSEC_FLEXBUS_ENABLE_MASK |
+			 CXL_PORT_FEATURE_FLIT68 | CXL_PORT_FEATURE_FLIT256;
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5ffe3c7d2f5e..a2641a3eecec 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -143,8 +143,10 @@ static int cxl_port_probe(struct device *dev)
 	int rc;
 
 	rc = cxl_probe_link(port);
-	if (rc)
+	if (rc) {
+		dev_err(dev, "Failed to enumerate port capabilities: %d\n", rc);
 		return rc;
+	}
 
 	if (is_cxl_endpoint(port))
 		return cxl_endpoint_port_probe(port);
