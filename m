Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF883C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 22:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjATWnl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjATWnk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 17:43:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E676CCA14
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 14:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674254616; x=1705790616;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JGjxzjTeUpUQzdzVEuFgadSKzIHik5oRUnEAaqgUC9E=;
  b=JtYdaV+ry5oWwP4Ug+nCZ0afsm1RFQNZHsiOcm4REjlsoSvpt0tm5bJy
   p7XQS+G6DbEB0hbkcP4GHckD/CUYo+P80kX4aBaSorKrqVavWSk7pIi6G
   DlWRzsw6RgcH9R5sXTFqosIJDv00F4cFVIquqY0Zs2KHTVCOyZQX+8CB1
   pGtd8il3x2s9gxh5KU7Q8HFFPJiCbD7cXKVZCWDG2FlFEJXVJeSCWo+PJ
   +gMgAn12qnZHRGS173mhUQaYswmeX5ojimS57MUPf/Y3WimBHoxe6qT76
   i7dn4nnRceKbVAwlb9i9SAT9LHsZxwVU0dIaCEbyx+0tYY71O+17Sr0rb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="323403762"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="323403762"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 14:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="989550965"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="989550965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2023 14:41:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 14:41:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 14:41:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 14:41:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 14:41:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7Hwq9CGeMFbg/x6EF2zZtID64ysGNlThi4RXpCfsjTyMRdrS45i7AiK/RpfjExUa1sc4h5QQU09/2wdm3D2ukk6EDUhIdrpjB9f7DY+6MRBSB1lOxkCJccEEAyO5OI6KXSat3Ak9v2B7MBBYI67VgIp++4oUGuSiRqi71ccVdPa43eqgM/nCRZcv71nStdVXeosGfhYK6i1K0tMg2LyUZ/5jAXlxhfo63t749ub6aJ7hvAPQoIcCocj4j+NMXdW/MHtb8rzzmTFxsnTSuGrKix47SW7MaessvDNat+hVKdnVl0CbmlA9nSKcg9y9byMsWvQTz7ZGmR2X+egI5z3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zLAR3qQnbnMhHtP9MjehbgUNJs1paf64Wf65wzngBw=;
 b=bNum08s0B6NMDvNE3WRWqJG4c45OrGBujYr0pN0qTsu+K/J2jg3+oPslIFZ/q9t1mJY2JaD0IRgSCJUX/EXmmsjeEXu6Ya54A2HfVDNxOLfeTteX5utm9SrOA0odgKnm2zV5JyUx8zQnfYpCteMui6xtgBL2xi+rkmpZUhYJzMr2AHbePwSB6G057GWT1q/hgvmlXHKbjRSRYCyvCgEjEe58NyzXePV0x18YDfEOk0pLEkNIY0X3e93M8DxaT9tI9RXKA3/KdgoIptz2sHdDVFZRF+NhWpJ5ovmDvFOa0UQDt0J7/h1nUfJlSC+hxCC4j5lDoKzOsY/V4vLjEriBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 22:41:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6002.026; Fri, 20 Jan 2023
 22:41:09 +0000
Date:   Fri, 20 Jan 2023 14:41:05 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <63cb1881b078a_3a36e5294ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <Y8hJKcy1993SFLLJ@memverge.com>
 <20230119124244.000015b3@Huawei.com>
 <20230119150449.000037f2@huawei.com>
 <Y8oeYfyqNuSIIxCt@memverge.com>
 <63cad185343a1_c81f029469@dwillia2-xfh.jf.intel.com.notmuch>
 <Y8sNfC1YQVj/DfBU@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8sNfC1YQVj/DfBU@memverge.com>
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 02af37c1-c51f-4936-0420-08dafb376c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFpmu2O9JZ+9+65ozzmksx5WRe89i9CvVYbKcEKoBO6gF7gqV6FTcOPNNMaac1+RTcUK8D9u8Tb879/idVwQUjvbyeeFnYE9l0HrmXKC4ZUJBmZJeSysGYX36JaSgWP63h9Wfed3q9p3Cbe3Fi93a/oNNX+81mclf7cUowWUyDQhW/neI3QcN1rL6BP6WS8MEFXjL5jHfTontKJ58lYJxDRkjvmh3DhTCWp8nE2UQNWbHb1a5CniF0O6B1JYySpH+Ug/VwBjbXBCyRNvVJYsX6lqbhPiG09TZ/A8eWcbKTeNM6osQjJo28IgqhdwS0K40s6Z2/HOyZv1Hnn5VEyYYY+eunzwWxATdQKFSkV4vl9EUmtAmLjND0Fm+sd0kBR90vttmJNcn8lRRJ0cv7S/3Errp9TpQp8HCKIWKF7HXCi8e7fHowijfSP9vfh3XWtnvNY/g5TxX7Q4kF2s5CyHL/QRKIuf8NUhFUFec7I+lyOjQ/NooF3oPfKj2munlHOiNatBK//9cNsgXCZmCmLOgLEeMTX+tmSOk8lkcM7sJ5qRKDi6DGlN24BH64u7DNl3ZvhVQG1vDYTZPm7baCJAeh1Ws/FcNnpc08B+DmOWpAqsKiQGXZsY7FmXc/O0WQWDzTuVFcC3EeLb7pj3nxJBoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(186003)(9686003)(2906002)(54906003)(6486002)(110136005)(6506007)(6512007)(26005)(316002)(478600001)(38100700002)(6666004)(86362001)(82960400001)(83380400001)(41300700001)(4326008)(5660300002)(8936002)(66556008)(8676002)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4LTOWZXRt0aYVQDO8lSQkTSqZRTB4tg5hushA/8oMUi7iNsFwPXelUcMd3H?=
 =?us-ascii?Q?HcMv4+NLGpyR/ZPeqeu4M10gsQegUMiF8FNPYUflM0UhLC1lnUgEy5/G4FdJ?=
 =?us-ascii?Q?Jp/LA6A3h6LmIMCSNkjL3RrovrJzHIoFXTTWCHbgmELlWWlhWdlesj7ofr/k?=
 =?us-ascii?Q?DjrHZ3mTpNdCVtk4x1Be2ViZnKKyAM3TQoBLaetwDBF1w4cnHok0YZS8Cj3Q?=
 =?us-ascii?Q?v5ztUA7DCiLLFIRIEjlaaOB6jmHsaaxnkJmXH4wBih/T0KIzJvWp7oWWQmJG?=
 =?us-ascii?Q?icFOI2kvhQtLoIh8PD3Hpih5TI1/zVmpoSc3a3ScMbxfLdrt+APf3HkE219r?=
 =?us-ascii?Q?qFQkzUkeXo7QylnXUQT6auHOkeSBLVftV0airEG82xnYXUpDp2xQO6iowHGb?=
 =?us-ascii?Q?jpvBVh3jOHz1N0jygMJ+n3H4AIqiMAhYI1ezG3TBIZ9FKEDG+QYgZIPCQ4em?=
 =?us-ascii?Q?9XW9wWFO51haeLX0SmJDfma2XHDmPSEhvBtFu6jCVQQNISIHNNubP1UDPg2i?=
 =?us-ascii?Q?aQaXarbrUq98dMv/Bbh8SyX6Y2aUlg/NdZ0alTiF0tXETQ4y/gFg7ezmm1ej?=
 =?us-ascii?Q?Z8Rh2BhSvzwgSy8n+0fHSLFjp3bxcLmiACnBaHwjevwNdgVd9gEpIp7ST0L3?=
 =?us-ascii?Q?GsYDnmOMmkh5Hh1gPxNdExpY5BYZGnBeWciaxBvOoKtSbYI8d6AechsWI+fH?=
 =?us-ascii?Q?XR/EKEKNtfp4UCICZVOyuPfKU9+g1q4+shUQ8vEoeFZ8gtz/8Hw6s081X+kh?=
 =?us-ascii?Q?X3i2UR43UetgLfBOLLn9takrVrZe9fSiL7gIBp8C6PoBg5gVRYCnY/yRTShQ?=
 =?us-ascii?Q?ShsTfCWKkLcxrSdwPLNSb7eAUVnd/kpO4m4y9MfMb0AYrU4BNmkWTaxh2sVD?=
 =?us-ascii?Q?Lk5cMjT5S3RD8v+OnNNj63rU9zgtzZd+4yXO3r007u7s+UTnSGSQDJA3R/53?=
 =?us-ascii?Q?Qcv2KRfYx/eM5wzV3n69mBolPC/xQOkqhMmjjshJFFaDzCoQQpoRQRIaBHW/?=
 =?us-ascii?Q?gh4DQcOPQahdLUi9oM1UEPvZW6SBHUXr00bz+k56TqIRR0lIa/mfnqXwsY/I?=
 =?us-ascii?Q?qeHZnn6q1I2e1c+BveZO0MAytSngiG0goQ6C16H1R2/5PqjllwiMX9J7jXgk?=
 =?us-ascii?Q?tIKpRAf7BTxeGqg/35a0JGyErTAIOZZHGzDkWYrkzBCPZE2HoCoefePXmhy0?=
 =?us-ascii?Q?TbqeHInDpBVHgJtyzUaKPruGCR4uAXpAJcfTV2ymZgc+Rn6KiUkMn8qxqILO?=
 =?us-ascii?Q?YlVwXn0gPTnVOCtMm0eFizB7xyiQYg3cHSvPDgXoZcxS+XolrUG7qL4l2uqx?=
 =?us-ascii?Q?P9oxNUa7uDA3ISqSYjcOeBh9XuCzUtIBGvTMzgkAxcc4zloIJ3pJKb6hFpFM?=
 =?us-ascii?Q?lK/XxwYYTdJM6nyOG7zX8xFU+m6+RVFCbCazKxdVtwLG72nscd1SMk1GdJ1P?=
 =?us-ascii?Q?ufdG1eooyKZCyjOVdgeggNRJIO5Pka8+G7Nnf/pfDhQliKmZbz+gt1241b+W?=
 =?us-ascii?Q?xMA4AXAT/dEyIOgyf4XejHX0HLXvNkWMeNJ2HRAU0N/x5IoDHk5PMo8ItCJx?=
 =?us-ascii?Q?15yzEFUufgpdKQu1NSZYcBjHSSo8II98aZ03wT9AoVhDu5RnytCghubTvEdL?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af37c1-c51f-4936-0420-08dafb376c91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:41:09.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbNDB6UFGdR0rm/GjUIZKBi1DH8LEmRwy3Jt8BQez5czu462tX7TYxYxKoo2pwA5iCUNDZJKHM6qbkzhXfrJ6P6ZwdJKzXEXxU45rTyCm0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Fri, Jan 20, 2023 at 09:38:13AM -0800, Dan Williams wrote:
> > As it stands currently that dax device and the cxl device are not
> > related since a default dax-device is loaded just based on the presence
> > of an EFI_MEMORY_SP address range in the address map. With the new ram
> > enabling that default device will be elided and CXL will register a
> > dax-device parented by a cxl region.
> > 
> > > 	 - The memory *does not* auto-online, instead the dax device can be
> > > 	   onlined as system-ram *manually* via ndctl and friends
> > 
> > That *manually* part is the problem that needs distro help to solve. It
> > should be the case that by default all Linux distributions auto-online
> > all dax-devices. If that happens to online memory that is too slow for
> > general use, or too high-performance / precious for general purpose use
> > then the administrator can set policy after the fact. Unfortunately user
> > policy can not be applied if these memory ranges were onlined by the
> > kernel at boot , so that's why the kernel policy defaults to not-online.
> > 
> > In other words, there is no guarantee that memory that was assigned to
> > the general purpose pool at boot can be removed. The only guaranteed
> > behavior is to never give the memory to the core kernel in the first
> > instance and always let user policy route the memory.
> > 
> > > 3) The code creates an nvdimm_bridge IFF a CFMW is defined - regardless
> > >    of the type-3 device configuration (pmem-only or vmem-only)
> > 
> > Correct, the top-level bus code (cxl_acpi) and the endpoint code
> > (cxl_mem, cxl_port) need to handshake before establishing regions. For
> > pmem regions the platform needs to claim the availability of a pmem
> > capable CXL window.
> > 
> > > 4) As you can see above, multiple decoders are registered.  I'm not sure
> > >    if that's correct or not, but it does seem odd given there's only one
> > > 	 cxl type-3 device.  Odd that decoder0.0 shows up when CFMW is there,
> > > 	 but not when it isn't.
> > 
> > CXL windows are modeled as decoders hanging off the the CXL root device
> > (ACPI0017 on ACPI based platforms). An endpoint decoder can then map a
> > selection of that window.
> > 
> > > Don't know why I haven't thought of this until now, but is the CFMW code
> > > reporting something odd about what's behind it?  Is it assuming the
> > > devices are pmem?
> > 
> > No, the cxl_acpi code is just advertising platform decode possibilities
> > independent of what devices show up. Think of this like the PCI MMIO
> > space that gets allocated to a root bridge at the beginning of time.
> > That space may or may not get consumed based on what devices show up
> > downstream.
> 
> Thank you for the explanation Dan, and thank you for you patience
> @JCameron.  I'm fairly sure I grok it now.
> 
> Summarizing to make sure: the cxl driver is providing what would be the
> CXL.io (control) path, and the CXL.mem path is basically being simulated
> by what otherwise would be a traditional PCI memory region. This explains
> why turning off Legacy mode drops the dax devices, and why the topology
> looks strange - the devices are basically attached in 2 different ways.
> 
> Might there be interest from the QEMU community to implement this
> legacy-style setup in the short term, in an effort to test the the
> control path of type-3 devices while we wait for the kernel to catch up?
> 
> Or should we forget this mode ever existed and just barrel forward
> with HDM decoders and writing the kernel code to hook up the underlying
> devices in drivers/cxl?

Which mode are you referring?

The next steps for the kernel enabling relevant to this thread are:

* ram region discovery (platform firmware or kexec established)
* ram region creation
* pmem region discovery (from labels)
