Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C212DC4708C
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 23:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiLEXhS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiLEXgq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 18:36:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7520BE8
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 15:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670283389; x=1701819389;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RfrzswG17vHT4L9FyXMgVF3ewsunJDyYWr3ZWTfrAxc=;
  b=JCqBiZfxr9IuPfr9BgS7H2BKwfA9/dDWU28E9qXs8SPyDiQgHUEReoAH
   lXndAu2sOoVWoIdGWnQbsZKUdMdt8O2+K06DiFOfQYtkXwhmJ1DjIAj47
   OIcs7MmTfBLuSZTK3Log1+v6+MuxkC4OQI4XCasA/98UJDD3kY2l96WRm
   CCfaJuatUbvfqNel5Ku+kfm9w4VqWcz7hLpeAhpzpx4lAii/tyWqVE9OK
   rbd/Bms21crhOh8Y1GvVk9OyoRGBBPjB+9qamf12P95jExYjpsahJohD7
   Z0X1jkLK6whqJLz2j1+tRjVmvtwznLCqxbUQEQmIMzsETz2/XtJawHJSS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="304109716"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="304109716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 15:36:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="678539332"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="678539332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2022 15:36:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 15:36:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 15:36:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 15:36:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 15:36:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtkMctyziNJJvICqR+RBUMFXqPTrOHtC4HNisrVxrPfmtxifccHeS98yAI3hhXq0xd1XCp4HQF78jltn05aEq4gvkhI2ttSVKerJMntOMo+fJc2mmtT7JvamSAJVtI02B9CVxKFwPUf07jBZqCPf/PbMuIvIT8veiLRgCAcml6K2YtvppKuBFYlENuB1OUhOUCkCkWAoEbdL5SSKLNPuStlqoLmIrDtG3e3xWCasmXwSbTNd5JHKwBZp9oju2AVRwnSY8viPzq2u5c5haMpHP+vJI1hjr4lJxghPuifHqQ/sGBANIULW6krq++QayTGbhf/1RbymXbwlE9PBfgE3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICYKs+K6jxEVMSO9cBNz0H+FJ7EBvIIZ+opcY3Shcyc=;
 b=aB7k0wKrvqfZRly3TQOPCpfDn1QBvV7b+NQxqGi9iJCEa3NCXyBZXqkcodG4T2LIWN9n9htFZxmLnXmuvaURHMVPPhvStfJOM2Y3qgft6ryOFUiARwix6Qh96tyEM6UEQneh5gAQGg4+ucGT6i3B25r96NyxzE9SUzwVxYmOfLlXD2z5ahUQh6op1yeszAiwb+rUaxunXQiSpApyh2qIpYvRVYpSh073+2qM8d4GLD7B7h1pKJk1jRW3bCXW+BCn9PsXQOaNVjbeU53mPfIF0wcE6kYMT/pRXdWOaTVCJXOYmg4cS7qKSNDY17dah9kU8G013k2OHDv3f7db1M+JTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5868.namprd11.prod.outlook.com
 (2603:10b6:a03:42b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 23:36:26 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 23:36:26 +0000
Date:   Mon, 5 Dec 2022 15:36:23 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>
Subject: RE: [PATCH v6] cxl: update names for interleave granularity
 conversion macros
Message-ID: <638e8077d7738_3cbe0294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <167027493237.3124429.8948852388671827664.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167027493237.3124429.8948852388671827664.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 650b7faf-ae1c-4756-1d3d-08dad719868e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79UhurUGy3ETlhmja2q+19Up3ts8Jo2rei1h9gry+mswU1i3csemPZFIa3p7McdEjLH8qOm+pVImWKlZGnXrAd0RVHDF9H3rQKlHLSwK7k65F/xp1W8wttr3dxxhF5YP0WmnF71oa8g4W7LP9n+UOuXigxiw9XNeZu1lul3eM4m1FR2Eu8lf2zOfzNsEEX8C2HsuS9E7PT7R9VfMZU56WVxY235dyR3MBIfeh6JUNZAd7NLX7JYJs5xXcVR8D7AZaCsBwGPRtGV3cGRhg+GaNBDKN9AcktK6cXKwCtL2+UPjhR5IDa9vgpsC3YdC2N1l9AqHEtGC6XlSLUlZ6vZn+9TJg4bBC6sSBTKObB5gliX2e+nySBBryheEpRkpvK+3Mjzh2WEcxkLrVy9YRUvZMW7htwgs+uyC+45IR+YLjErkmc/DSvXY7yaoldCvDqTzVRRCxqFxiLoUhiYn8Wo1USS8ZZS8fx4z+ynw87t3TySvUashL3ZqUEbaP/WUjV8YkQ5fdH/Fd87HImRyhQJ2l7p1D49ubFbKCt9QD4p3MMh3tNe9m4fZB82v9M681pnfiwlCfDXZ/SELV15tkYddagfgzo9avIkhW0H5DJHvPCzrHZGReazXXjObubD/tMhA176PuhfV3pM8vp0IQWIT8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(86362001)(6506007)(478600001)(6486002)(82960400001)(38100700002)(186003)(5660300002)(41300700001)(107886003)(6666004)(6512007)(26005)(4326008)(8676002)(9686003)(4744005)(66476007)(66946007)(66556008)(54906003)(8936002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0wjubygNmJP6cIP1iSg+3Fg0hFt5h9Wm3KHpAZRV71r6SzaK5UQgSZjZAoe?=
 =?us-ascii?Q?ZmC93ZuDjqQkk5JnSD6KjadFuKEq2eZqPRQMBFC/XtcVQpVkigqipZX5mru7?=
 =?us-ascii?Q?cpSx3TcVQY17WifGlORnR3M92i1GjRHXowoQAQ+X2hBGCh0OYYNbiwLuoRbL?=
 =?us-ascii?Q?XbWXlGpxYKr/KQsPULbwGl6itUtVsXF4NQDCdytEhQCDStFNXUpdUWkfiV2z?=
 =?us-ascii?Q?FlhYCIZtWhA1JLVKIpFnIwOGxn1p3taYqgZc5bSG+BMA7WHuAepRd5zwxcV9?=
 =?us-ascii?Q?qgoDDm4Zn5wt21r2GyyietPt4Ly1C7BcujRjqPHTJzYdTcQR/Fk0j3Zy6WSu?=
 =?us-ascii?Q?wiknfhvY+jvTec4vsYmwI0S/mvLYQ/LYZXAVMzKPooZreSqVvgcK0Vxpx6GK?=
 =?us-ascii?Q?apaWE5OTXkrLSnIfOSKJ0tR5ogqbr8hSqKOnY0Dx6XMxpYY/8xS9SEuLa1H/?=
 =?us-ascii?Q?OhcU8+DcRO3BKfv6o+NpTI7Fj+67rUDqhoHlF7W1tt2HWLPsofyrXLwjLLhL?=
 =?us-ascii?Q?bvB+/DhSKg7oYoVCPI92xxozo7QKYyDJKnV/fnq0NVJ/moHkgIkRIA7RZSvQ?=
 =?us-ascii?Q?Mlb4WcZ10UWE6NSr5GfnxWfZ1ZVHKzX3KCi0ejb1V2KcTixSzIoLXOCBGN9E?=
 =?us-ascii?Q?8jwhnKHhbfrY2QMKwUg2zl86fd8QE4urTt4EP12sdrlUEcZLUSwpICssZk4I?=
 =?us-ascii?Q?dtqdqHikczsa4ArbTFhcFsO2RfuqZky1NSLe/IL7K4yoTFoZQbOjF5Ej0ueQ?=
 =?us-ascii?Q?lzFN+1+qV4O42WCUwy0/X6mGBMmaRPIJeph5npdEvkhUd09JjMiN5MSxHJH8?=
 =?us-ascii?Q?MrFcBflvRcS+ITEp1MdyLrGIjbcdp0JS4xWwVFNXduS1EJ7d6sPihemRYgvj?=
 =?us-ascii?Q?Ol89MrtNl57JBXEGhFV3Z+6AvQq3nx7cDtT+o/92wpx0B1WHLbJnGbWHTXGo?=
 =?us-ascii?Q?AnDiBy8ehAAAKlqI0QnIfOM/f14PYQ/MVIsOszKi/3pULgatpMfhsoPSP9kC?=
 =?us-ascii?Q?0i5d/si/oDMhmXOj/fqoxklZtvgZOY+WMvq8IdiL/rAf32bsACZ3dG0W0wX5?=
 =?us-ascii?Q?GB3kZE8JxgZLzTuzi6o9HLGLJHr9Xc+kkhZr2TZadxpTYBmMtuHHKJ0Drnz6?=
 =?us-ascii?Q?rvzZuxf2jdpWz0acHezc+BTAcKrKn8Px6rzfCEXVuiIhuGrIHQ87pYdzM4vJ?=
 =?us-ascii?Q?OkK6i97w9judgDmNW5gwtp81tTyR6SHdqPbDuDSQjexIfPktMp15coozcobS?=
 =?us-ascii?Q?RZ9OhE180C2sOqSCPLhwHR/RZWgnaURSAlfSFz+5O4hOnlz8ULVeWGy3LM5r?=
 =?us-ascii?Q?ls2ps0E5AYb8oJIV/su+hxrkSkVWUjX5++/M7ymTEZun2s+7yPB4/G6Q7ojx?=
 =?us-ascii?Q?SltWzVoonLKssx85G3d+GTHfsQ6t/iOucJAiB7Gj8kDbQFyFDoUl9B/ISQsX?=
 =?us-ascii?Q?iVvw1qrw2G1cRuTTjL2f//fYNO0lpafybpTVr7lwvuTd2MKZKBuw2TtrhKjB?=
 =?us-ascii?Q?3Wl+hxB3nP25wOMZiOfVfEHXcH+mzrmbfxqwjrnKNXZgANW9BO7ZvyAeT7qQ?=
 =?us-ascii?Q?4mKPcMX3HlWjnHC1FepL4QshgJ+ZVhvcNOMfZ/tGuhmb7NFxz83lrf5jZEyT?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 650b7faf-ae1c-4756-1d3d-08dad719868e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 23:36:25.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz9x/jDv2vf9n2eLjMq0GekwkdjZAWH76A6GHJRUA3KxqXyg60xvdOCsSbN7J0x/SElU/7bQzRlp53m2Yh6sjtvgXjOA9vWiCZmXk5+BmrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Change names for granularity macros to clearly indicate which
> variable is encoded and which is the actual granularity.
> 
> granularity == interleave granularity
> eig == encoded interleave granularity
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied this and the IW to for-6.2/cxl-fixes.
