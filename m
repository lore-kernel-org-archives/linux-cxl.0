Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7517F5
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJnTVUzu"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5136A11B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698464349; x=1730000349;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mEoYb4GLhKOOBySoL7pmsK9+2n2XsIKkiCF0F2j/Gyk=;
  b=ZJnTVUzuceIglhnT08l5orw8ejr6slLjjOoblrcERlpBgbSWZ02vfbL7
   AeVm5Xjw8XFPd4TX/Gpi9rTrrA0B4CyBVgWiCEsj5J3iBvca+3TjNRzx/
   +3F+ch6d02XVgvNjH13FFhSgjO5nzAzjkgU1ROmRjY/Z+gMV3ejmbROIe
   JI7sYDzsNHf2g2D584CwReU3Xm0MQIJmxQ4PlXgy0GtBb4Rjf6pOw8/is
   oBWR8sZOIs4rNMVMV1sFyknet7UEMaM2M1cuVRfcEzWubF+US1dcQyprg
   6gkWyVtGXAMk6VEaEZNfas16drURCYm6YT18tVyd0e6OWlOMFTaKP3378
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="387690039"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="387690039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 20:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="788985067"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="788985067"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 20:39:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 20:39:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 20:39:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 20:39:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 20:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKoDvKZHtXA7ND1J2bXtjrdTpubXEkFTXzeuwCuhNh3xq78NKY3Q4JiimQ0REgH7054hcX0218I6k58IrUYsfZblAq+dnmgTRg5FhfW2rHDAggZXorH8LLeYxFRd55ki5eDLvnuP6MqrbyYBZWGOa2HVsQzfYny+Xf1Kcgdim0WZoXOqh5shLgmqa5h7kbsNidZGfqI2Ttawdqm0iC//IJaoplC1lgVPw8dvUDIzKQJm9BEzIFZbFPhlNAPwBfcvoatt6lORKFf4YNOoF3WiXm5oNSf6eRRm5aArKkvhMmmDnwlPFEg7HGliZgAVg815ZEp/6DVpnao6t4L2cI9W6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b43vLvA224kQPCyUHNmuOV2ad2Hk/PZxMZzuOGb09Qc=;
 b=lYv9P/ZDK7cam4oPfNRvBje83QibrLGPqzm148NDKbAn/K6luQefEm9q4XOiiGF8wxNwFdUowvZG3g/RiVMSQBAiiUYDqHHlGIx9fws90pAT7BPrRkUQYjefWqhUys+mdbG2bkowfDLBOMXN6WTE1u6qdIRciKABWpTgDzpp2fK1bHYRc70TuXjc5GvPQac6BrNAxiiGcfiuNCJHvbKVRwqDNzuUfzYh8SFaGKXk8MuR1cf8hTKZR5Yg8ofjEIei2/8R1xYu88psCRFpRWAIoi2awuIvBTdB1s2LP5cxsq1ZTG+pKXUSpSvtQbSlHiZHF23ekVX60diM81JqctdGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Sat, 28 Oct
 2023 03:39:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 03:39:04 +0000
Date: Fri, 27 Oct 2023 20:39:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Jim Harris <jim.harris@samsung.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/2] cxl: Add decoders_committed sysfs attribute to
 cxl_port
Message-ID: <653c825587190_244c8f2944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
 <169747907439.272156.10261062080830155662.stgit@djiang5-mobl3>
 <20231019153843.00007850@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231019153843.00007850@Huawei.com>
X-ClientProxiedBy: MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 215629ee-8901-4f78-cb28-08dbd7676e69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fatXDlSx+j4h3Qea749DmqI01/rleBzZNfhzaJkuFGMH6/3Cyv08UvckEM/rTHOqK1ZIAJO67m3mWEEvfdgp61LLw2Y4xSizs5DfIUZJ4xAA2tTGiYU2JbS732YdmLN9k2ve4TFLO3bd9I0fIujOn06grYoOVdOUwS6BdMttcBXbSCzkUA/jduRY5ucMVHoxPy2Ux+j8US22WXM/NaqfgEzgWlDVJgfEbU0dGMZfF1xVKZ9pEeP6/ybzuY/P8Smq3KUFCkaV47/ibPOv+ElRLDr4/jJm3BC2oTAM0TTsDGY5gf1sfA/ePrmoXy8Jlz5AsUxtM0pfiOIZC39+x0bafLRmUPm26vrbClIP/DMERsAgTOMOzIBd/f983uUFcbtDOQPQowSWJCsKbgDY7zF34UkBq1qW/uF2ggvTBpKUJbt0aCu/mzQdI2eZ8V8sUysH0nifklNzJxB7kms2kqRzOqlaBM0S3GXl14RH46Gl22csPgZA4q28t8BiCwpMQPxFEmg6+s6fAJKcHXLMDqSAZ9awSeAQBs4LnbQaTB9FGXPEIo0aKpejILrWYci3OJJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(66899024)(26005)(9686003)(66946007)(107886003)(86362001)(6666004)(478600001)(110136005)(6636002)(6506007)(66556008)(6486002)(6512007)(82960400001)(38100700002)(83380400001)(8936002)(316002)(66476007)(54906003)(8676002)(5660300002)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NzqEpUMrmer0+s5161fS79wKP+SkfTT0ZCs7iPxvSwzCxHaCIHoZ81r4nz+?=
 =?us-ascii?Q?RxnWJscaQawW+LZGgR1oj6zw/ErO800K6QPXlNCkMJcHGIRNeifdLhW5TsrS?=
 =?us-ascii?Q?+nczXSobJ37Juir+FT6HyOqWr603ppeIdH+XA7YB0WNlQSpUxF4gD1X084bx?=
 =?us-ascii?Q?eWaTN9sZMZZBbkUMmlThnzRQPlW40eR2xW6mT0oG7uyjZHq/+NMlWUNwn2cN?=
 =?us-ascii?Q?p2ZTZpfJB0kE/1qwMj1gYWie0Er0MusN+RnR6lRfswdWk+G8pQDaJji+MQAD?=
 =?us-ascii?Q?HRkBCB7buTkxuM0NjPgeZTfDpwhZkpsn9waTLcZKQXjj9DEG5E5xq/TgA10J?=
 =?us-ascii?Q?uqzse/33lOeSE+R/Be57SUZXZZqW2H+9Jylyb8O7bqxeq5VtD4gP93A/w8Bn?=
 =?us-ascii?Q?xpWl7dvYXm7ERUbcBJgQIgg47xkbuckbiV3VGwacxqDz3V72hmg7t7y0IhL/?=
 =?us-ascii?Q?lt/AZdPNCXnnkPRJW/mBAJ3OI1OJysCurR8SyRUS1eczP1WLQTlhJmGO6mlB?=
 =?us-ascii?Q?PVchJ2T5fVhkx/QJ2lrJY8OZ+1H+5vD6PPB2hzRFr4CpZmRIrVD6Fdbdy/Ge?=
 =?us-ascii?Q?E7SEMNpuUb8A6NYGXyD6H5FBf5wnJcJPaXEat5SdCcTdYiFb8F/HkVqKLYDz?=
 =?us-ascii?Q?RWaPkx1/X5SYKRFgqRl+ZG88ZKg4wPavT7OqZ10ru7YC/ghrSlw9ckS1qBRn?=
 =?us-ascii?Q?oiw7k2Mqtml1Y1ko3jtXtctX64fCNgjDoMfBtEzJuFGENzCVgYaFGvP2JgHE?=
 =?us-ascii?Q?RKTWETHDa1FZmEqhqQTzGd/MGJjujEjhQfvO36nj/izlSHjR4ujwoTF2A6eH?=
 =?us-ascii?Q?1RB6e4brOy8tarpMEOoYUBvHfLJqdKgyq8wWhUHOcXit0OhM1kYWaWMdglj/?=
 =?us-ascii?Q?wRgAuSbU5qEm3J/yph+VpQCzEhmQ+bIPgOotADoeHW9Sqh9rVqClKR4PwLZY?=
 =?us-ascii?Q?w/nL4ahNC0t0FmAIfuXjkARzitc2mgXRJ6w6+mkxoOqj6JbHdIVOVZcURa3A?=
 =?us-ascii?Q?ARbI/r4x3IMoLExb4IT0pNVrAItgdmLjHT7nIlDVtrRZQKXWQMwOfWwYHGwb?=
 =?us-ascii?Q?kEwZ+yXlmk5w1TQDM4Fn7LSuopuf+dLYr7d/Zb0cqnoKfEFMC/l3hHe2KfQX?=
 =?us-ascii?Q?AfMI7YsOPkqfVcDveFjYacTq8AFFRH9Extthu8DL6eQXSNnIsnTKItkX/cUI?=
 =?us-ascii?Q?p9TNegepiicvpMHIQbOZQ02cmZuZhkMzU/h1nzhRzT04WkxlMIOPdMSAeU7T?=
 =?us-ascii?Q?QHsJyjBhFFWVKXKxW/UNHBRmfGGPU7zOjqtk122q53Tel2zp7nrUPcVocSSs?=
 =?us-ascii?Q?psOjilrDJorxfPxAFVmSQl8YbxZ8ml00QM4qD/+xXGwF1ruW+kiSt+6Y8afk?=
 =?us-ascii?Q?J8HIXB8KBqS7MuXN5jmlm/LKy8V7NiVuDYo970dSyXfm50gvSBBdkd+WRVx0?=
 =?us-ascii?Q?tydlfOYAakmgOfePy9pGcizs2FCLrKHryC0F2OcXHJ3pGlqCwIMcmGs099l7?=
 =?us-ascii?Q?NP2sW1BUSG7Jmiilx5NU69oUcjoBLgAjPpj+Et1y6kn0YmvWRdo8Bljr7sAK?=
 =?us-ascii?Q?1RL/dfbV3FiL4ls09lpFYJkK53rwIRUTykSUwOj8xG172Xbnoga74TzHzP6B?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 215629ee-8901-4f78-cb28-08dbd7676e69
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 03:39:04.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFiypTCKarHLvSn1lS6aelewmcCzXVo8Kwo8+a6ARGrJp0AkCIJZXvLFbGM6s3y6dt3Fiq4R2h6NZNChzagS0S2G7h5Tnmj8KP9/O6SpB64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 16 Oct 2023 10:57:54 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > This attribute allows cxl-cli to determine whether there are decoders
> > committed to a memdev.  This is only a snapshot of the state, and
> > doesn't offer any protection or serialization against a concurrent
> > disable-region operation.
> > 
> > Reviewed-by: Jim Harris <jim.harris@samsung.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Seems reasonable, but it is adding ABI so the docs are missing.
> Documentation/ABI/testing/sysfs-bus-cxl

Agreed, folded in the following:

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 087f762ebfd5..432610f41aee 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -178,6 +178,21 @@ Description:
                hardware decoder target list.
 
 
+What:          /sys/bus/cxl/devices/portX/decoders_committed
+Date:          October, 2023
+KernelVersion: v6.7
+Contact:       linux-cxl@vger.kernel.org
+Description:
+               (RO) A memory device is considered active when any of its
+               decoders are in the "committed" state (See CXL 3.0 8.2.4.19.7
+               CXL HDM Decoder n Control Register). Hotplug and destructive
+               operations like "sanitize" are blocked while device is actively
+               decoding a Host Physical Address range. Note that this number
+               may be elevated without any regionX objects active or even
+               enumerated, as this may be due to decoders established by
+               platform firwmare or a previous kernel (kexec).
+
+
 What:          /sys/bus/cxl/devices/decoderX.Y
 Date:          June, 2021
 KernelVersion: v5.14
