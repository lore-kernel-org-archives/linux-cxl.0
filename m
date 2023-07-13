Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F25FC001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 21:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGMVVn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGMVVm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 17:21:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95926A3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689283300; x=1720819300;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZlUSYe4BnEdIsU43cJt6PBCRs0FQAT+uI4uM7jt/l2M=;
  b=ge0aTU8LqsBR/YRPvQNz8MrXSNe77lKdlThJYvsGesFf7p71pL7Ec7Za
   OUX9YNe98cgOvQLqSjl52HbZjIPkfNnWQ9OD6bRp/31KTYulEwX3t5vpZ
   jD/1k0+iQPk5Yq1MePa1joqdz9+cYJA5HEv9dh1bAGvF4t7n2w3ZKm+z6
   7Ycq6k3XGkrNPsfJZ2focz4+pkZbS736pl0D19hHHQd66ceilDGFWVEMI
   oL2VYROw2fkEIKrbBbm78Lydbid+pHgiU/vmho1BdXUni3GkkyFvBNe/q
   D0GR9wWkGvzvRPVJwADsmtSxZiH/oAuljLe9TQ0wSlIL8H8gZgWc+YzSd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396126123"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="396126123"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 14:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812174171"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="812174171"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2023 14:21:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 14:21:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 14:21:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 14:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI4TsTDC1iBVRI3RAzs4WKqZhqsK86vFFXZnSINckPiluCexWlsBEgFbswPflZuTD3OntaQ2N5eDB1knCut9KVXFAFlSWI571LeEJpXMMovodGl6uhC1JmJAe69+df/zoyCM5AaeKq+km2gCmmz/G0Llc3+6F/HkpGEd7vSIzuT5LS8E+zC0t02cjxAXPc9CnqyCxpLCFxHpf3e5c9ntJfan7MV2hDzeNSTvn0dRSQ7nihFRNSdDKPK0tvT4tKeO9KDpQwEvNGtVteOBUNLcbZDz1z34mHOynRU4wGg0xdjjsBX1seyPCDYZ505xhBQ/xvLcQCPj3yuiJt3ZIvPN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwX49KFezKL4PhxOa+chV+UMPo6zA/oxDv3F+CD6l3w=;
 b=ReKzSewPZu8W8N4fEVkClVjE8Y5lczQvw2et8FlwAK0QdEEjQRGouwXPbu87OFKKg2uuY991zEzHvt0DCATb1pNRKrZNKg+JTagZyR46ykJdx433HuxETt5uOnEutcZBm8wtKP2uergxaC9ZOISr/0U1IOnlryjqw8ukEveo9FlUOwhDtzUO7+URcon9hRc3Zf9J+k/b+21SylzQbgUKZFuG21vLYpBn9t/i7/cP9KOWP1LrJHTIFoxrST+dvcK5c4Y//KFpP695gd5mhVhUVG+k5U8sKK/TDzIT9S/JtROcb0e0DxiOVHWFALMHvMSOncnLauZ/YTd/rBA8tZCQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 21:21:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Thu, 13 Jul 2023
 21:21:33 +0000
Date:   Thu, 13 Jul 2023 14:21:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <lukas@wunner.de>, Terry Bowman <terry.bowman@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Richter, Robert" <robert.richter@amd.com>,
        Fontenot Nathan <nathan.fontenot@amd.com>,
        "Kodamati, PradeepVineshReddy (Pradeep Vinesh Reddy)" 
        <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v9] cxl: add RAS status unmasking for CXL
Message-ID: <64b06ad8e5505_45a6294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
 <0975a0d9-7b9b-e959-5621-928ac90fcb66@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0975a0d9-7b9b-e959-5621-928ac90fcb66@amd.com>
X-ClientProxiedBy: MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ec7a18-dd17-4f9f-6b74-08db83e721bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEWrcO0kQ7lRxGHdX6yh2tbg/hyfSoxNHyCnpNsiK5coRWH8XNUYVWe9LpmU14fEQtAgy0ogsi+hWHy4zqvd3bO47UbQk7sCimoCbK4ug0kRlD/ZMK6C1hdKNEzOVP6+WKVWKuTtIxFm9b1hxpYehwAGRs08yTRsfxyYmOltkobKfBNH1fFENBkYAWngLutjUSBk4NQO0G/9lTgnY9nvEoVILPD7+me0qTZWbskyM5WzdjC2+sVg2rBNuZoAH75dZRyPdQ3TxAQ5v8TwIbClkMjKHA2dC+LlcRGwgEg5PihSxvZt2/hq0NPOb21gd13jpmYuENjXj7JS875GaVy+9TAJG9IZr91fdXArb3gyOBryZz94U5kDw22591AiVmVG5iq/uqFz+t8WTYEjIDf2r00jOZ/3DJiJd4xBdQHxdj8lAWPvbhw4acZuz78kjZPM80uNlqt37Nhyuetsk88ufdj6C3YxpamOmF0b8seXmWmzVO38fEh2/o9ge3THC7BdJroaKtYpbc5O2FnKqWLY/8DjN5NW//9TJKSCM+yjJ4coQqX2eeY8KCxO0PuDFz5P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(186003)(26005)(6512007)(2906002)(53546011)(478600001)(9686003)(4326008)(41300700001)(66556008)(66476007)(7416002)(5660300002)(316002)(8676002)(8936002)(66946007)(6486002)(6666004)(54906003)(110136005)(6506007)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+ITJsUk980QFISqIXR6piJw9CtzqKXoJSUdj4tVxt3xBnanWNrFjnMeDQ4q?=
 =?us-ascii?Q?BpdpUJRaNpz9YL2VZKzclO0NtNjgDvQVb7tOP3eNY1lOHBx6im/obn/gKDjm?=
 =?us-ascii?Q?eIbm6L5CQR5Ump99jrj9MjClgy1lALQYkxX2K/dL2yrLvpNHN89b7BNLWkyn?=
 =?us-ascii?Q?e/sDudaUFQlnepS5B97cq/LIB0aYz6ia1wQykp4ZRX+JKpirti4Vdl/HMUSx?=
 =?us-ascii?Q?ZFGfGI8yJSALWG20yKODY3D/i7QBAov86byfIjixcNJGUjjURlyqlfX5AZ9E?=
 =?us-ascii?Q?HTyZ1BLc2urk+sDGm9eranTZGq/mL20/0FXm2xb4LbmfTxUpxeYBlmc9FGmd?=
 =?us-ascii?Q?pHRvzRxf7OWeUH54NevPMQzXJbZWQq4l5aWet4GGBfCdy46P1B6Eb/44Ka+i?=
 =?us-ascii?Q?YaTz54bWjkz6tzyYQhyDhFbB0xcQ3+2lNO+EBGRzKA9vRqr53BTqWPylHCqb?=
 =?us-ascii?Q?i2/n5oVDlUDdUXvVOo1a1B1f8USVZUjDf8F6+tJhsCskpU18Cr3x6aMZGKxM?=
 =?us-ascii?Q?bScz3c+91QG3iwrMeddjD9zT6Q6W7DW+GZuA+TsOBSCVEKAW190CsLvvMx8L?=
 =?us-ascii?Q?wSOHI4VQzTuPBfOEGD0KffcXkPBTFtDHDLKvpDIdDazqQbfD+jU6QtX5kAHE?=
 =?us-ascii?Q?mMzNZnTo/aYnNpqgDA5p1Vy00uQY+uU1j9CSsQ5BCH4YXmqeAlPawmWHO7cJ?=
 =?us-ascii?Q?RIc9YPbNIpTEdesrTdp2U/i4mmd1iskg5imELp2/mIkr3zKP2rc3SuAvIfId?=
 =?us-ascii?Q?jjS869n0pQzowbpIakOsJRSSXLb6hRMPE4cJOAld4DKdZwqiuore+MSJiVtL?=
 =?us-ascii?Q?ViXG7Tmq9YRt1KS4pJ/FMMU3SphEn8QHMXu0ECWgUU9qUtHEjYSksa6KLmV2?=
 =?us-ascii?Q?dF9UTZhXl+eDssfpVnSPrQNOMeuzM3qcJX/JZqh/P4+9vyDwf71GSKqV4KIS?=
 =?us-ascii?Q?BSFdJ/hu2PY4hBg0r7sJSAL1PyneSGTWTy2gVpsWM57m3Z6w/YBGj0itNTwZ?=
 =?us-ascii?Q?OnpXzveGxoOnBn3hYMx2EK3ud+5wn5a9zZnAwnL4/bTJdqx0vlGcu/FDp9MP?=
 =?us-ascii?Q?yUSibuwDHsNRMwM5YKSbf728+a/5pSlL1H1oaLTCqmJxyg+/BVjtt6q8Qbld?=
 =?us-ascii?Q?TzUrnMdNJ3p5j/9IA9sR7G0TvHIEQQJJlW1xAmoyHGGhjr7dDPjjraaUM2bJ?=
 =?us-ascii?Q?r3bPEjrAfjmq6eSCBgAfaJqpw1GcUYrD6NgqexYCtPFDtBQfi46qDMlxND0v?=
 =?us-ascii?Q?bHH5ny3LgpzVu54AYiFTmSNSb6pRum8wrCn2ysdxOz5kLLAnPnvakflkqQuq?=
 =?us-ascii?Q?ZPX7COTQwO1qIa9DxpIQ6VMPghaa6JN92xyzriYxPl79VY+684eVu+TAAC/l?=
 =?us-ascii?Q?2odKRUs1IPV/+9fr0jUzmpjQzOUnNhAQqHu3pr1kp3+1FZQaqeBNYJfXOUR0?=
 =?us-ascii?Q?e2WFY7VAGDmePVL/CkoUO7BqlUFlD8mEKLFJPi+WlvRZ978bkOL/yM3GZDXw?=
 =?us-ascii?Q?JaELFLCz51ZXFU33q2ov/Y6s7HgElov63D4Cg5AtJvwW3KpbWi/VPKG4gIKR?=
 =?us-ascii?Q?t9iHwcAa3ibB9660k2y3TkHWVb8pf+qscf3Htwb1Zlhg1jEp+3kxRWUPpcTw?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ec7a18-dd17-4f9f-6b74-08db83e721bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 21:21:33.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nI+m/GBLB/qfkA6SbJEUC1k8GOWVw/0KrdsHHzaxLizH56cupCTu27oeqg7UXlAsJeC0Kmqv4xucKOZ8RAciB51njlEbQk/J2XMgSrD3NuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Smita Koralahalli wrote:
> Hi all,
> 
> I understand this has been in upstream already. But I have a slight 
> confusion on one of the checks been done here.
> 
> On 2/21/2023 9:55 AM, Dave Jiang wrote:
> > By default the CXL RAS mask registers bits are defaulted to 1's and
> > suppress all error reporting. If the kernel has negotiated ownership
> > of error handling for CXL then unmask the mask registers by writing 0s.
> > 
> > PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
> > errors bits are set before unmasking the respective errors.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_regs.h
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > ---
> 
> > +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > +{
> > +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	void __iomem *addr;
> > +	u32 orig_val, val, mask;
> > +	u16 cap;
> > +	int rc;
> > +
> > +	if (!cxlds->regs.ras) {
> > +		dev_dbg(&pdev->dev, "No RAS registers.\n");
> > +		return 0;
> > +	}
> > +
> > +	/* BIOS has CXL error control */
> > +	if (!host_bridge->native_cxl_error)
> > +		return -EOPNOTSUPP;
> 
> Why are we checking for native_cxl_error (native_cxl_error is CXL Memory 
> Error Reporting Control _OSC bit..) while unmasking RAS status?
> 
> RAS registers will be reported on a protocol error and the protocol 
> error follows the PCIe AER. Should we check for AER _OSC instead of CXL 
> Memory Error _OSC?
> 
> Because atleast on AMD systems we log RAS registers only on Protocol 
> errors and we use this CXL Memory _OSC knob to report component errors. 
> Is it same across everywhere? And there might be cases where protocol 
> error reporting might be native (PCIe AER) and component/memory can be 
> FW-First which fails this check..

I think that's reasonable, it just was not clear from the specification
that CXL protocol errors are included in PCIe AER as far as _OSC is
concerned because they are conveyed as "internal" errors.

So I believe it was an "abundance of caution" more than a requirement
that Linux expects control of memory-errors before proceeding to touch
the CXL RAS registers.
