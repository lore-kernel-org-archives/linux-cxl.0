Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED8DC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLPQ2x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPQ2r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 11:28:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729363E5
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671208126; x=1702744126;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AO/dOIpadRT4ExidIk2jfVWHqOLnX4qPkqlyzU7cN8k=;
  b=gFgCdlgruzD1sqRsY/SaLbDDPCQbVZcdKv8zD+62W+vWuBnmaoNHZt9o
   A/9u4ViYxXC0mcpAxNfC8633lu+bIQsa6Irm0dpRQOP/aScUEWeQUly0a
   v0SGzpI8b3u99yZxJKfGMsnXLZgupVCcomwSIWCJ6rR0C5b3ei4tMXZI/
   mWum25kboQI/+x+O7udklvOZ4cQqC2/aZeYomTYaCEvrvyZQ8dNhe555O
   bBLHNJq+myBJfB4qeucSTj3FBc6zb4T+SImD1yquVTFWbIxSLcDfKxPir
   JQ9NPYtERNWezdo7fCpMAo+UxCeIGbtLfud2VnEE7hsXV31eIA2JI1QsC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320173663"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="320173663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="682350677"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="682350677"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2022 08:28:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 08:28:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 08:28:45 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 08:28:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPH462c9hnZpm8nd5etqtGdWrN0dqqYoEKZi/55tN3/ZLRunI1mn+qvMpsVQrHTrCCi8Dto1cxJ0L1i6llNpAyUkOx1Kl3nuteWHqylheMZh9RxlP7GAlfc1xbWCTu2DGpdEo7Edu3aZJwqACyFuFeI/CC8wJcta1aLaEe1ZDBrIaL9HDHgss1tTFfF2bQiFNYgDCF33Kvy9vPbDij6OTDLHsUk5jbRG0Tb7VMQX2YLNd4CLLVVdJ83qVweddrtcRVpQi1Ie5kNv3eR2Kuh71Efr0UpTfIJC0r7rViHx/86C9LHqFoIe1Na+SvjQorcx9QoFykhOfcJ5scdLux+/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8TgjchXI7CMoSBHkR6pw/qLISTjpH6anJgYnRNtKzc=;
 b=DzdhB/GlvzI9NicR6q1PlQlLLghkMAlwknpyUafyImhy3oI/1ihMqfcqDBFxNRVB1/rHzwRs5Sy3INYlfHiPYugXKf+aRevQcIRNrZRjuOBeldHStiwdaqLlIIA8BIVObOFhMmNDpFN+S2/iuPdTi5hp0E+B1tIqDcZirRVD6yCHjm9Ik2zZN0oNCrJRIpeiIuQiNDY3V2sKH6qYfl3q8yNXJiIYLmKnALQ6BTAXX8QS04Ppjq8+YZzOAsBkB4YjRlP9OYooLbruvsIeCzx5QoeAwKyeVhtl+5NNXF97OZXSbvVj2pVq0U8fhIc1du715xMWhAcSQ3GfF6cdp6XNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN0PR11MB6205.namprd11.prod.outlook.com
 (2603:10b6:208:3c7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.21; Fri, 16 Dec
 2022 16:28:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 16:28:42 +0000
Date:   Fri, 16 Dec 2022 08:28:41 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v4] cxl: add RAS status unmasking for CXL
Message-ID: <639c9cb9163c9_b05d1294fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <167112768345.3343090.11728168471813709343.stgit@djiang5-desk3.ch.intel.com>
 <20221216123452.0000605e@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216123452.0000605e@huawei.com>
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN0PR11MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e698b1b-9a5a-4f65-77b1-08dadf829899
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPIIK7632iti/gjZZDk1CUHVHZc/jKIV2taS8hmfMO/vThO2Ul8D+dva1S6G7DE0V5RCPyzMVSbMK4WUh9v1HRIH9b+r9t6edM1Gg0umH59lxsgOMsYQMDaAis6b2XbLO/omJNookyctB8luMVUjXMMJLGggKmf1wb7HstnpFUi0drngxeO7D2RFkA/T5IsqPzSu0FcAX2FMpaOG7lDmbUVWU6NnFzviwsKgciK3PyQXRql2fAyZfWHezd+80aMnBiY6QaVZc7/sDOoDwTHGtHIIR7sq3veBguQ1I7eJJVh6dVxyjS3yQJPd0ohxoG57OF0QPap2+4u+UwwfBGjfME8sru5eD2PYdjZjl7waq9/FXCsvc+NUhfx2ZFLcigDfTS30e2FfEOC5ZQ9qZgx4vs2CWIU8tSWX8PEow2Klt8Z/gr8BOrgK2xz+8xpyRbZOiEPFqScNWGtWerxEI64Tv2ZJyBSt2XI8e1wzBqo6yFp2hMrVmwpYBzhEBB1X/+RWzqSj/+yy9mr6Hqi/47cJp4Gh6f01dYqSW5ODJ9ji760CQd3qavtte5u8PyXlMbqwJpt/ihh++gLctuCzFeVxFC7XoZRCLI4dLW9CfI7rH1rVgCShI5ivpwZMqqPbbgw5Oqh7qlZEs1mvu6QjV/NMkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(186003)(26005)(6512007)(6506007)(107886003)(9686003)(110136005)(8936002)(2906002)(38100700002)(316002)(6636002)(478600001)(41300700001)(6486002)(86362001)(4326008)(5660300002)(8676002)(66556008)(82960400001)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFNGI29scF5V34XMow4RoLOZbE4zFYwLw5wLhwCWigNdKh5ma3XEXzEkJ65w?=
 =?us-ascii?Q?63CIBufXMrbMn2JjkY5QtfBgrsgcA7uqJEhIuqlUngHwG1045D0pv+C44W9L?=
 =?us-ascii?Q?qApKhZJ+o09YfbJEEEmyJslO5LNC2vD4DggU0IWkYxCwAqR4D50TXiI8UjiZ?=
 =?us-ascii?Q?/dIX9kCgRlmPMlnfQpix/Gz8o71ElFOvDdQx8QIQfj3W/OtvguAP2wkZILl4?=
 =?us-ascii?Q?4xH/uTLbqz05RMJDr8+AHbmebNI4LAvFRrYn6NDQCMv09DkQLvDPWR86a59r?=
 =?us-ascii?Q?ibzXIGb1lxuDwqzlQqz7b0enfUiEDoREEMQKx1Z92QxCX9f2zBlmUF1ZGYUo?=
 =?us-ascii?Q?pXgevEvXF3k4xMiOEfztye2F0ZYfrzVu9GXEQg4ve6E31nWi3cDlgJqZCFNE?=
 =?us-ascii?Q?SNd/rqDoiPkkfc33YyNQ0Hn90fXMLpyn75ZUwwOvU5cteXgqFEXwo7q2JeB5?=
 =?us-ascii?Q?q8AMYxAIcaSGr8DDttJD/2pkRNhqdf5y7wnAkIHILIPNF6oTZ0oNJezgHYV6?=
 =?us-ascii?Q?urJ7xRddAP0whmStLIP9R4taEXX9GeDhEOnkGj7MDuHSBLBjJ8bEd02Evk5h?=
 =?us-ascii?Q?BNNaPIM47fmqR+xWeD5UOb/aM62MMkeb98B06ndsWno/WTh38ixNtpiCwzT2?=
 =?us-ascii?Q?Yqt8IJ8/0XiTVL+LYmEF1DQoM3x843hO96MP/oVZyruybZBGZJROMMWg+Aay?=
 =?us-ascii?Q?r/okQaM3I1c4BOuAnQyTJq+j1i5vPi63XsWyQ3bDRiEV90gRWhAg4O2r5Km1?=
 =?us-ascii?Q?Sdee+cdFzfX+bd84Ap/AVLgg6Mz51yWl6EWVHat6h+kIgqohAWfR8LeB3Wii?=
 =?us-ascii?Q?KNXmzheu3OHHRRqmy5lIXHvdLvDVx0k+go0SV/fhg//4xXoUYAZ16OlLM8Z7?=
 =?us-ascii?Q?6znjwQgtnOIuMrj6KZK1zdJApDhFablU0Q1CDXnQ9XknoE+GbljtqnZ7imwo?=
 =?us-ascii?Q?WzySETUt0gnmsPLTlEQAkqxrS5pix+WiOb/x1po3atP18upT0fGjONR3mJnf?=
 =?us-ascii?Q?exrvF1NrrzQ5rkvC1KR4X1spFuBe19EPv8+E5Z0/PrQfYZ9dTOxjLN2d34tK?=
 =?us-ascii?Q?Q6Hdo5HNMoKo1Ye3kvYSHTzZjZYqNytBDoVrCjxgsiqNfB7duxdF0bYt7YAg?=
 =?us-ascii?Q?NL9+MuX/dX6RKDlzZ+UeSzJiXdvThlwcmFKekG6yO5fwbLtD4+hRdMwW65+Q?=
 =?us-ascii?Q?8JHfTok3TywYOgMTkM0wvrliNARib4o23yE89v6vBV54uGrI+ki6JzARg1hO?=
 =?us-ascii?Q?mmqvBNBCDm2Piztfb6bpagegKH+ljGRcoXY8crih65TEm2LSH8voWMWvSTlH?=
 =?us-ascii?Q?EpRD6YH01N5eHCF0URbtGdQd7BmeupK6Vi148D3Pfiq3WYI3ZgnXulqxYE3N?=
 =?us-ascii?Q?zPQU3tiqGYsXWAn/7EJ0muKzr/nHP0qaUq22cQBdFwq/cICnu0sUEnHQoRAP?=
 =?us-ascii?Q?ZE0wqTmtsZKb1Om6U8LehvhaXuhlo0R3s2+VFRf2rwhXesm/0kyamU5gNBYh?=
 =?us-ascii?Q?8F9ZZWMDRHlBqglLDL3R8Cb7wWHF3y4AEXonJA1LuG1oS9eDrGRWeRCUtJgN?=
 =?us-ascii?Q?C5emTWIMiTh/lUiC6IM/ruN78I9OUSJ7n1geYC1fB+qQ8tr3IwCMlO5otulk?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e698b1b-9a5a-4f65-77b1-08dadf829899
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 16:28:42.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNJX2riMUrSrQibbqQZIm/TXwNy7Anh/FvV9+U5XFFZ2RNiPBjeMtZRyO99iMy8fJsBGqzMWsXIRdaH8YT5BVN3VzzsUbVJsAnHeWPQ25sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 15 Dec 2022 11:08:03 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > By default the CXL RAS mask registers bits are defaulted to 1's and
> > suppress all error reporting. If the kernel has negotiated ownership
> > of error handling for CXL then unmask the mask registers by writing 0s.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > ---
> > 
> > Based on patch posted by Ira [1] to export CXL native error reporting control.
> When you say based upon this, you mean cherry-picking just that patch off the
> front of Ira's series?  
> 
> That raises the question - are we treating this as a fix? If not, probably better
> to pull that change into this series that I think is simpler to land than Ira's one
> and get that queued up then rebase Ira's.  If we aren't in a hurry, fine to queue
> this one second but then you need to rebase on Ira's full series.

My expectation is that this is v6.3 material and that linux-cxl
community needs the time to see what this does on real devices before
committing to having all the errors on all devices all the time.

That acpi_pci_root patch needs an ack from Rafael and Bjorn, not sure if
that will come in before the holidays, but once it does I will throw it
into cxl/next.
