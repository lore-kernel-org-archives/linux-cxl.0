Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F794C4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 21:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiLGVZF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 16:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGVZE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 16:25:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D90CB9C
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670448303; x=1701984303;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yk0uQHLikEmZem0bPQbH1sMv/czAQ7JZEtCAJLbyoh4=;
  b=StpvaTU6RkTYPTp64KlJXSuSkL3uZMUfmVfUoJEj7gCXdlxoouANI6Q2
   8nA/KgB/AotvX0FAUiqVg8VoXWJvnQhzEk2mbEAmhakESCAsMZlO4GMJJ
   /YFy1BIWV0TetjoYNleRN1MLvpHhIv7vIQlNgySAoA4GJMGkhWcT03EKj
   y3z+pUqORiAS8VweVv33WsehouCxRCJwB6Bt2jenWAK7YMe5uapvbaLvT
   DoppIpzpKzCHk5AYoJNMCz4dxjmspHlP9fy2c8ohoYJNHZsrpvhWXFI+s
   +/+r3lt9Gp/B5EBXqgUorudynnb4uEh2kPhXpxcqS07zpC92MmrAFZwy7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297364207"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297364207"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:25:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="771246438"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="771246438"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2022 13:25:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 13:25:02 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 13:25:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 13:25:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 13:25:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl/NSpZIgi4lKJ0vG4ZVK4cAGgD3/eoztvaatU6JohDQ3N3Om2rFTlmm9v1YYwy7p+t8uCV8rfJ3D4bF5plqR5aeAuPDqrvLLdLx5lu2Lj0JaOBQwmDOnycmQLHhcTVXU7WIV36rA4Dq41is8eaXoYcCWsVyn8TUlUIrZGyQ3g9Atjy5aMXf1tRywrsMHswxWgAwl0uixsiCRBvYqdHUQAnDhx9wQ7DqoOSFDuyYBml2oD2x2F6rTO1IoQmnhMpJrePshChjSrTJVaxPUw41hgsL6ngDcBam5IlGDet1BQ64sJGGAOox1POUmbfUHMjt3KqAdu7/a0SLVfLnmfFzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg1E2+RQHy10OlVWz+QJeTgD239PsBVRJt228R0hKDM=;
 b=Ph3ykAfmZni6B6nNDqbaSCWkkbS0xJJHLoLGz9nXBOQnwSxL3c29M0LzTNZwVhefEj0B1UY2GLqM1cTIUl7Rg+PuhCSC77HLUX1aNPUrt1TJhBgf3LIJK8Ze/fT5JtblfRHYJEJ8EzoqtkXuUSzCPqhARzeLzMecrOKm69R61UwxZugzRxfZFPGKA6cf6O4RKKqL/NkcxAAwCmy+pgdzdE6BUxuUPBsitzg/QWHYa5s3Rm4Ge7D3/R8ZM7LjVh8X7HTl+eYSVl5587Kyrd3qawz5hMQgL6iWqhhL+dCJgdVsGP+MzGC4Cn9dwPor471N4lqwJ3UFKc3nc4ePn4hyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB5967.namprd11.prod.outlook.com
 (2603:10b6:8:72::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 21:25:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 21:25:00 +0000
Date:   Wed, 7 Dec 2022 13:24:57 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mem: Support sanitation commands
Message-ID: <639104a9bb0c7_3cbe0294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-3-dave@stgolabs.net>
 <638ff86e7e44c_3cbe0294fd@dwillia2-xfh.jf.intel.com.notmuch>
 <20221207163505.iteqrwryjxxjkyde@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221207163505.iteqrwryjxxjkyde@offworld>
X-ClientProxiedBy: BYAPR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd3ee9f-e003-454c-f12b-08dad8997eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHvZ2FFtNN+ma2LUd9xYeGptC9CfVbE3WAasePx2GhNb1VdLXr81cWI43G1omP4T+mQBsgTMfKRKEtGYGnqQFf3iYvt96ozA/FXI1FE+gjhuPfC4bZ6iedWE3lkPU+BlJjXCQxm3PcZZ/pTtEGoRtafHk/OjIb10I3AXau8i5YCvlbzVCZ/5fqjiQsSa3NI5jDaKEyoyv88Dz9wvYWQ2XZEKHDs7VO9BjeYF9BXw8B8NMd0yj3zNenfc7ReD4A2l1nYpYIZULZ51eBuwtLj26MFAcq1SEBvxqgGLAmIuijjuQcB60iZm0zVH4jk+yW4Kzkud50NTB2V9/RV0YIwJ95rfTYs2zG5G5kkzHbkgaX4sQErf5sAdPcbb+HnFwJ9Kh41hhW+Rb9z2m9uxqmphYeaEAKr3HrlQkYhtaRl9MZcT8MHg1H9GeDtB4dkMZglyI38g2i07yoLfAVzLcxSUl/hCRJHWpdkC6uV3XfJkN/4IYkzrpctHtme7JawqL6JcjYXvm+Lw0tDkkqYtvTL3Dkq0lMk0YBQ9D74S3WTG+4P5RRGHMv4MoUcRnLsBf1fT+5t16hYIGny9sYmf29/nVKnJZYr2lJ1neYDCeN+XAJ6MFjrv6/36ucYTaBUzdiGxQcrM0ess+EumDufmRERHng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(5660300002)(86362001)(8676002)(66556008)(4326008)(66946007)(66476007)(9686003)(2906002)(8936002)(41300700001)(38100700002)(316002)(82960400001)(110136005)(83380400001)(26005)(6512007)(6666004)(478600001)(186003)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GHqyKU59ewoCnSZ+A1ajAciCn9VvuB6brhOqXW5a6oeIA07KJYf23Rhn5Cuv?=
 =?us-ascii?Q?yUUKNOmwbm+obOYyWTruiGOx4xZQVEKbhuAzjEJKplsGqrFyHBQjzr4t6jv1?=
 =?us-ascii?Q?UynQGPq8ArqUp8iECAZ9MRsMc/yVJPr+fCsJrhoWz6eD+ZUJNcGtz2vFJq1j?=
 =?us-ascii?Q?Dx/9XCv0gluAkjqLQU9+PjHcYDXfmYGQt20MjCeimzZfBNouRa30/ixCDtzj?=
 =?us-ascii?Q?jIw6ZZbWFKxAqIAhWNCyA6RRKIjnjWWI+g1XyPChJ2CHrRvHO8a4v2oY9Qnm?=
 =?us-ascii?Q?NmYc1FxtuKrMqGgJw6+rR5SCrREbv4Jbt78j6wA/TGwpgi+vf3FGhLyXatxg?=
 =?us-ascii?Q?xYAXniLpb4MKrGzV6Dx0tLWLJIiZYEtjZMDjDe3yw7i+6IIIrQcjdfxtDLUL?=
 =?us-ascii?Q?BHQlHtQZPLvhR3YU8oZ4hHwnn+MK+EL1F/YqlbXnK6ANt+StEa5XWRAaa9x8?=
 =?us-ascii?Q?sQQExkZ3eWwWYkvXQLhhU5FsfZQrPnRLvtE5V6yPe2iqAqqK2zaIZXIhZjnP?=
 =?us-ascii?Q?KLEBeOKNhqm25Ndm/pLoVHk6QAiE8QsfX2aKGft2Ke0fOFH2vw3myRYOlOwQ?=
 =?us-ascii?Q?3PlmBA3rWvI/lNeMLKGBcKdRqAUGR1GplQPCEh/UjjW6M1Mdt55s3vndkpus?=
 =?us-ascii?Q?HCM1RuJ6aYM9SMXM/uPyRt6oxile6Oi75TFjKP0mTqG1XG5ArzyI9TBUk8rU?=
 =?us-ascii?Q?TWGS/IeAFQq0YLcszg8mWm1mzc+ArTPrZm1R/LPu4ZR0IJEkPPd5lKbH90wq?=
 =?us-ascii?Q?ZNyHjE7sVDk0s1URAz7zFgl/mp028hCsSOxSvzRGY3Eq+DFE4pFANJ2B2Bfv?=
 =?us-ascii?Q?6TL0SNTtUeEtXdpnRoRwwCnk995xXT5of20Q6altg6ziyIxzbvA4wd2beBN/?=
 =?us-ascii?Q?9MIKPkIe8GMr9PTqfTlDTA7bA4Vws5idxFhzq+mRD0f2ykYbB55O4ga5DgMA?=
 =?us-ascii?Q?gqUTeZVXQ9aPcQM+PxRpcXZ1P15fu2Av83XsIhgO2PzOqN8z5idVTxX4T3P2?=
 =?us-ascii?Q?2GCbeTlBlNgW0WjpRq6Sk1qGdgZMhpT3i3kggc+xCRSHW6+dWQd5f5E6CExZ?=
 =?us-ascii?Q?Pdd8xsX1HVClTwRQ1lpm1GOSsbwi+sNJOo2TWWzLcLoGrfkGDHrXLiiq7OMC?=
 =?us-ascii?Q?5lIlWFXNwqdnv2YoVNNDPa9TexeOulOTIEQoNI0t05TWHRlEMXtXSGc14gqC?=
 =?us-ascii?Q?E5+m1sjwgBuKLSyQZkN0x9KcxAy+CH/GjiNmXcNqerri+LhhdjAepw67OkYp?=
 =?us-ascii?Q?nzkjTWIXIKmIQLR6uwUwlVm4ESXtAcpknCfpSLAwQZLYrPIw+9I1HMsMNFhu?=
 =?us-ascii?Q?lfPyL7LM24AZsQiHYp/svYBfyJS2hoeG9kGWP/KRW+78Dbq+jawkhvawjAhA?=
 =?us-ascii?Q?Jq+OTMeggwhyX6cQC76u/XJFfqCM2D2gH6CFftqEkVkGwYy4Z9kIeJZ9b4Lm?=
 =?us-ascii?Q?S0GBYWslxtDcuKBsUkncGhqc/kCTi+EX5rWpuUaIkA2He661hhVEcm0JBWXe?=
 =?us-ascii?Q?JCsLAAiPCvOsVygKc3K1r4cpG0VFNzZQt/Vp61NwntvmK2uFLTPFZF/Uy0TL?=
 =?us-ascii?Q?+FBVvxl1pEucFF6W/HcOicOor9exhSwyXehj1JIzlgkTshNTwo7VXI+iaNhI?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd3ee9f-e003-454c-f12b-08dad8997eec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 21:24:59.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi1vkaeXi9YSILqMbDbHMKn9Q3c6Yt4n0Ze17WRc0yGW3Ac9kUzV3BhpOmACKU58OVfH7xBUQz4waqBQzZE8f7U9xIsbT3OfiYG2vDcoF1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Tue, 06 Dec 2022, Dan Williams wrote:
> 
> >> +static ssize_t security_store(struct device *dev,
> >> +			      struct device_attribute *attr,
> >> +			      const char *buf, size_t len)
> >> +{
> >> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >> +	char cmd[CXL_SEC_CMD_SIZE+1];
> >> +	ssize_t rc;
> >> +
> >> +	rc = sscanf(buf, "%"__stringify(CXL_SEC_CMD_SIZE)"s", cmd);
> >> +	if (rc < 1)
> >> +		return -EINVAL;
> >> +
> >> +	if (sysfs_streq(cmd, "overwrite"))
> >> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
> >> +	else if (sysfs_streq(cmd, "erase"))
> >> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
> >
> >The above needs quite a bit more safety that the device is not currently
> >actively decoding any HPA ranges.
> 
> I'll look into this, but overall I am relying on the fact that by hw, writes
> won't have any effect and reads will return random data on all locations
> corresponding to that device, sanitized yet or not.
> 
> >I realize now after sending the comments in patch1 that Sanitize defeats
> >the dream of being able to timeslice background operations. On the other
> >hand, it really is a special case that is only meant to be run before
> >decommissioning the device. I think it is fine that it monopolizes the
> >device because the device is literally unusable during the process.
> >
> >> +	else
> >> +		rc = -EINVAL;
> >> +
> >> +	if (rc == 0)
> >> +		rc = len;
> >> +	return rc;
> >> +}
> >> +static DEVICE_ATTR_RW(security);
> >> +
> >>  static struct attribute *cxl_memdev_attributes[] = {
> >>  	&dev_attr_serial.attr,
> >>  	&dev_attr_firmware_version.attr,
> >>  	&dev_attr_payload_max.attr,
> >>  	&dev_attr_label_storage_size.attr,
> >>  	&dev_attr_numa_node.attr,
> >> +	&dev_attr_security.attr,
> >
> >This likely wants is_visible() handling to hide the attribute if the
> >device does not support security operations.
> 
> Can is_visible() work on single attribute? I was only able to get it
> for an attribute group. I had also considered ifdefing the thing based
> on ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION but ended up not caring
> if security file was shown as we have the remap scenario you pointed
> out, so hiding security features became less appealing.

is_visible() is a callback for the group, but it is called for each
attribute as an argument. So you can do things like:

    if (a == &dev_attr_security.attr && !haz_security_commands)
       return 0;
