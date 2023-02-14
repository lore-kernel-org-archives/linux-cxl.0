Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B83C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 01:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBNBWy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Feb 2023 20:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBNBWw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Feb 2023 20:22:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0B468D
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676337770; x=1707873770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9bhIixy48tsGxoMcAjDEYsRHrUXiNqyAgYaPII/cwF8=;
  b=iYt8Fjc+Nz0VG8cBWAEetqH1PbzJjkr87a4ZOAnSTmMbUCy6oF5Gj7MZ
   yHGL1rYTx+/qXXiG/q99SJWO8Vtv/6p4OP9VxFsT+kdrBzg/j4CHBgJUm
   OLClJW7lv1asopfi2htmsqt8sW4u9Xt/vWpUjhRBDn7HvEHiEEKMnbfjV
   cApgVChaviPEHm7PYbG1/PDNORGFW8Iuhgx31WSy3WN6fnLeecSyYZsRg
   7sX8Nrj9b27au+u1xotvg6CsipOadwPbbgvsEBkOSQKCwmXFLECExhBFk
   WrJgweoPxyjaP/wLo4v15Ckun2DzYvmaBGOFNDp772IHPt/RZmG54OQ8t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395665026"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="395665026"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 17:22:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668989326"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668989326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 17:22:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:22:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:22:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 17:22:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 17:22:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeCPY91/6Jr9AMcnZtZdVdabYhX6ofcoXg2BIsIkYDiMFnBC6L6YIqU97MJN7KHpUyrIkbu2VR6a6/+4iN2RRzCInAtKx7CNAKpycJ1LRY5joSaslqA34IvDTJE46p7g8au80p7f57kjIzfXY679UC4mfg8U/Z+B+GqV9NBAr9hL04XLwR+XBuC5OG0K88s9NIV0bXQcjUedRWDNUfuIbQlAkJRErWMyKvZdYSkbAsAjVmiw4/k2D/Pgy+bAUPlzgl2EYOq4u7SC1KbHbKt0u4ut3cfGYTefaiauOh87nHFiLbl1gnarlUuso6r9p7vm08wwkP3wmkgQ4Jy/X2OS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePgQJeCpYEjPJUB8pzie8iInDkiM5EmNXr1KsJLOZYY=;
 b=K/Uk09DJreWPpuN0cm1zP/zJVcsXbz5bPrTBavOU7/yb7+rKFpzpvCXYPknP4SLX34eVjm2rxKF6AoeSfFdNW9ziir1wgdEGpK1fgfWeYBbPoLATM2ANd5ygWaV4VbwJet4UkS+CYe0Vhddo/7YFwKo/znTcwcpR1iccyAihoy+qk2mhEO+PadR422Uj5Q5UBOqS60OuoKnFkHZK9u4aOolrgpo+9vgBY+uo0rd/nhv3X3ugOK4j2/IaC5zVrSOzOqH6zyy6bYYQgfcN1fnQpO/FjaGDoRmSt5/iO5cEp2Hv2+UI7FiiSGhwyhNNRMQ6hhbByEmTqsru56w1thjd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 01:22:47 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::2d60:e304:64cb:71a0]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::2d60:e304:64cb:71a0%8]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 01:22:47 +0000
Date:   Mon, 13 Feb 2023 17:22:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <bhelgaas@google.com>,
        <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>,
        <lukas@wunner.de>
Subject: RE: [PATCH] cxl: remove unnecessary calling of
 pci_enable_pcie_error_reporting()
Message-ID: <63eae2639fce0_32d612941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH0PR11MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3c656c-262e-4637-9ee1-08db0e29faa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTRYqNYbQHGi/1nlVG3cA3nWM7xw7wDSZhhFweY6ahX4l5TeP74BW2QXkqpZx59sFPuY3Zp1qvvoVEvnGZUP9z7fir3VsP64gs7xUpYATYm6vB4CooyqGIokAAGWTnchbcg6H6ixvMZ2GzHkv9xVg89h4veRYbOEVXONS5O7YDNgMm2s3bSWiDabCILivImoOMwoR4jwSwYy7Fze8qTpKCA7icaN8VLUICwSGR4pKSezPz1w0b6RAv9/TqdYt9cPzj/OCSqLdnRXMQlSvUz7WHK11F69JYND9PRYGKnxw0PzNNBD3j3fHT3xg7JIfUIl4EbQb0od6WSy9P5pf5OgrKddfapLB5m3hi4uyGTu2vqgDhV78AOffwMdanlvJRvRT/jBJMudUA0ODJ+yy60NNYDRRueFMqJQlKrIlmX/5KCqU1vuYHQzvkhx0rdeoSjbPA3hDjtuS4Clansx7zdTBCbAnexxxSNJP4jKKpB/yJ0Kh9y8NMLnarve8yjPDCvOyNeWQ350YIzS9bEELeiJYrX9S3D9tj34l8n9eyuZY8Ah+dTBMdrXMyCxhxmvXuGqdyCArXdBMbHEKQj7DQ9F5xN1aabuJ7GVskiWh2LBhxnpGwM0IX+KI+cnvGorCMYHKyuhwahnsmj6cnPA/si/ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(316002)(8676002)(83380400001)(38100700002)(86362001)(82960400001)(6666004)(6506007)(478600001)(26005)(186003)(6512007)(9686003)(6486002)(5660300002)(8936002)(41300700001)(2906002)(66476007)(66556008)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MoFXWALoptaKQnpvVH6WlWOULFM8DHxak0TqrCjuGwkuxgTEqEzgq5gvwjW?=
 =?us-ascii?Q?wsv5+95+MxaW25MuFvscskDSvEde+OfqM1UAVdiVdo3uJtxLvzXjjvjvCibA?=
 =?us-ascii?Q?2taKF39y2QGc3ORELoeFDDZYxWXUAqKRLCVAy04mZyfpMFUC01LF2hDo6cZJ?=
 =?us-ascii?Q?8aJdrviAf5rAUjvAsZ3vknUvUA6ILvtwOYZ1arsXgFy4vEzbSCsVGH58cdQl?=
 =?us-ascii?Q?72SOErQ58+BEdXSNlmmWEvD5UpJJQ25vjeKbF8kNUk8J0O3nY5AjjfMnnFVM?=
 =?us-ascii?Q?Ew6JmBGlnq9+i4L7p12RW0VCm3v4n/ArQi0285WSYLTPKCCSzpHYnaPXfPi0?=
 =?us-ascii?Q?QgvqTlsupwRLkosq8KcISS0EBELQGYU8lUhGpOGc0sm50ZZeu1L8np00rs23?=
 =?us-ascii?Q?xFzyWQMtExBQ1j5oE2r70bj9Qy/2fsCQHlRLPmiggPLmBmnOzNgYoj/j3orY?=
 =?us-ascii?Q?1IhZHDg5/leBf5fi6JRzxmWWeP8U0dmbFRCMRrHYOrETQnsNrwY18DNAQ5zH?=
 =?us-ascii?Q?hYYsnyJrOyiLLsAhghChQ2QSLLpcVNfXg3j9oO7dJH//arMC/zvlnTR7m9lF?=
 =?us-ascii?Q?H3X99iYk8rd18sl6tsj2Oo9ZkvAqHcDWCg7PSjLpWW6QGl7ShLbdhp2vk6qP?=
 =?us-ascii?Q?9IjGkR+P1fobpvhvrwRNFjmAgzaoMvx6EedeZwh6IMb3k1dkg1AuQj8whcrY?=
 =?us-ascii?Q?cGU2VHm9aM1/evtuHMCioj5k2MOc+DNDMsmAqZeAT6glF9rZdpTFqFm/cG1M?=
 =?us-ascii?Q?WC01w6VpmTypRgjszK1bTA5oT/b0RRWyo+f1DrkKF4ilb+qbh3qpryzWZTzY?=
 =?us-ascii?Q?MQ4HH6atW1iwMgM4AtT+xPV1+k5LPsYG7andaxWEE04fAIXwG/aAJM8q7YuY?=
 =?us-ascii?Q?K7XZvdkVZNv3WHHLAuWLI8cbI00TP5dGDRxDHUP0DBnRyws4j6zmwlglLLsS?=
 =?us-ascii?Q?eaTDw/99Nq2tSnpXHohtwGkRK/bOXW+0vJygFBSSVAnui25ROoqhk3qt0mFm?=
 =?us-ascii?Q?bZIfQsqV7YcicyvGEExYQnSu35s/NR8LQwdBY0QS/fzZetLX9j8iZDGWEitI?=
 =?us-ascii?Q?mGm6Q6YfybFSTwOv/jqJE311iSigSnm5p8Ud/xYm96UNqxzNrP6BqFmufoED?=
 =?us-ascii?Q?v3DDQfMdxwihGZpdq0GsRKOSA05h/tPwG+CWBwWKR7Af9L9qKTlG0tFppxnF?=
 =?us-ascii?Q?KnJi3K4D3R22bE6Cc+Ch09ivoZ7Lu5iwODoZgO6BZNDD+SMpSENhnN8phpFT?=
 =?us-ascii?Q?gSdyrP7Is7DvWVHik/5NKQuMBhcNqICfaCGPUuTiEDlvPP6VXzMzTeBsCg3L?=
 =?us-ascii?Q?ly+zrX/HFUNPJPCji/pQLiJUJprvH01kbIGHqPMewy2g7Wte0br8t/cgF+Ce?=
 =?us-ascii?Q?WpMWA9SXZxtqiCLhkWJrT9uUQXwtuKWPfDAYWX0QuZHTTGwJQtogcEWArXQV?=
 =?us-ascii?Q?LuVkOh5Fwtht7vX9Xa8f5tm7c75jE1JvX8xABRGvn25P0+4ar+zt9cnmQ/4a?=
 =?us-ascii?Q?HvncanxwekpmYyr+F7EKV1DIlgt5oE7gG8thAgfU6C8K1gKQLHwb6f09GTEP?=
 =?us-ascii?Q?OfRj9T3DRRmjY0Lq/KbndLK0qcdqhNkBjXlI9JOStvNBGFfo/B9O1BxEpoA8?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3c656c-262e-4637-9ee1-08db0e29faa5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 01:22:46.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SNc4rqikEMvWgJwOd1OdJtk07Dr27VxiI5bqxn1X9sXWNP8mnvUceSqpCztT2r1I4zpy9NU7SY58jjW/pIqZYt7r9o8rWopm5qv/f87rrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> With this [1] commit upstream, pci_enable_pci_error_report() is no longer
> necessary for the driver to call. Remove call and related cleanups.
> 
> [1]: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")

Care to fixup the Documentation as well so others do not follow the same
pattern?

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 0b36b9ebfa4b..a82802795a06 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
 errors because device specific errors will still get sent directly to
 the device driver.
 
-Configure the AER capability structure
---------------------------------------
-
-AER aware drivers of PCI Express component need change the device
-control registers to enable AER. They also could change AER registers,
-including mask and severity registers. Helper function
-pci_enable_pcie_error_reporting could be used to enable AER. See
-section 3.3.
-
 Provide callbacks
 -----------------
 
@@ -214,15 +205,6 @@ to mmio_enabled.
 
 helper functions
 ----------------
-::
-
-  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
-
-pci_enable_pcie_error_reporting enables the device to send error
-messages to root port when an error is detected. Note that devices
-don't enable the error reporting by default, so device drivers need
-call this function to enable it.
-
 ::
 
   int pci_disable_pcie_error_reporting(struct pci_dev *dev);
