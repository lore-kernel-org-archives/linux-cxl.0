Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B09C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 19:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjA3TaV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjA3TaU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 14:30:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117951BC2
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675107020; x=1706643020;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EoFl2JWLm1gY9s0cRcvlmrxH36x7xsGAG2OXmVeYCpk=;
  b=aWvSN3KiIO79HKtDdyIshyAnw9q32W3kBCw/jZnm5ljjaEE+0rxUtPIU
   v1mec/aaXP0OJQA6S4Cgpiu8q1PV1IrVEkZ/eBdWtbQTqKa5+ideXMSOH
   +0xHnLsl4swpFzEi/4gnkeM+23k/FJ79LQEeV1YZRpY7Yp8EbQvaDukUS
   sPCf+kw0G98d3fG+ZznmeUBHKTC4AKgP/A44PsgXMBCjDlIbvPDeNLpSR
   6znvHgs3vtynHEv7rfa8IAuOqMfw/Apg7iUFhTMPk/jIKRhD7YlYxRJqa
   +kqa0iWuyTlpt7xRC5UBwMHPEffkyG1zZtH3eNm8wL8W5JU9rv0vswAwa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307998191"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="307998191"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772643562"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="772643562"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2023 11:30:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:29:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 11:29:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 11:29:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVO0+CI9X08Bv4Pvy1iOuz5u4P5ELLixlbKJkfvY8goN0ZEMLmcY0/hvTMyIP33kQygG93SzuLiD+njuyoxdeRYzclOmkFJEmQ8dBIZ53ZE47qx2aiRuUcy5MhXws54/B4BJsPTpidGYLJ+AOU8RB9LgbkKNnoyb9zYFQsDTXmDnY1ba2qLRBTlCSDzwf4cb9FPYERnJn51AMSj9OYrsZngbPevgv5emIrCHcOlcJeNkQrm3NBOjK0E3mFT2BUCxT2NZqYyvwYRkfwdEsnON7uog0/3lH/TSpl9mYI0ESs60hs0B1ENrFBWHAAV/IZkjJPuqLtd/hPcmcrM9G2VnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA+dHcIOq+k8efMQXoApwh20iSPWjXQysCqpe2TytJM=;
 b=lQ1fEkSnntmtLvtZ3w8f1b3ZBR2ixdO0/XSYh2xHMGNRDBo1stxa3Xe0Kmh/lJk37J2ho2Aa1nmo3NySkQiPWHK91r4jBzhXjKILlxsLpgw94jaCMJDsdXiwSn9ZZUcuiMTnetSQ6CidKO45QQYzc4UoMumi3SWIIH4QFH9F0S6VdWVWAvjtNv5v3B5KiHJAmT8Gy4wvKDxqvuczzGs+7ktpay6X+s3H6iQei8mPfKRCCHwpLg8UKfK32bokwLEZRhE8zBCGDN0nfJfGlufxUC6YWLW2eGiPB6pDyBx3IuHkxIUguPWg8xk0buZ92Xu2PjRPLTBFpulej+bvaWjUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 19:29:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Mon, 30 Jan 2023
 19:29:48 +0000
Date:   Mon, 30 Jan 2023 11:29:46 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: RE: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <63d81aaa8182f_3a36e52945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 3350582c-0af6-4c41-00a4-08db02f859cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LWV6m/P+Pb8oCAKKXBYtovescJoPfrV+oamafER9jsGAv4xodvFhbm7yNtNjvN8xHEBe4rT3T93QkQfWmN4hJ9ZIHZXvbcO6v7G0BowYpFAH03P/dbrcwKyE4JQYMNjs6agbMrTESVRkUzKhhYqJrOgKPjpYcuqVn6IV0V5+ft2i4Sybwr7DrbDSdPas3hnIHaHHN1v9C7Ytun9CAD9Khf7NW36s5geLO76bdZ5UVjZdIX/Wh0HKMT7S+gU6keE5B75mC7Xz+qfnedItHW/4PIWvXcDPG1irp/8Gk7R9Cf9vXv8zHanGiGghXvHP0uHyHAQap8rQhn2cKSoPB1CSYSDdNg1jJKIhz1tObMeD3FEi2o3PF1xtm0oA9uHG+FfltuF81ozr7vRS6uyoeb3nk2GyOhaB71YItrt63C7AMKohGfMmqcRakvtz2ZFFJcGt0x+DiITVjzHL4D/9yQg4mfBn7ODeOzWXHTtkiDpEfxjhYyDHlyf+9tB2v6desTouOww/qveUGNsWpn5VxDv1qT+YbugkrV9xbSh8YNEQLTSFnURHADC2Vcp7obdsxqy487tbnmXyh28/roeEL/OSoSafwoLK87bS/2ruHsz7dXE8GVxaHkUEQWnZ0y+jtUlzYGvUQ3yYb182ieBXQAXQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(2906002)(82960400001)(9686003)(6512007)(26005)(186003)(478600001)(6486002)(316002)(54906003)(41300700001)(86362001)(38100700002)(66556008)(8936002)(4326008)(66476007)(66946007)(8676002)(6506007)(5660300002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69ZaTn2HXIIS+2DDVVZ44IUH358RIbwtNaeM2A0EiKFkfMlrtqcIa/sx2kX5?=
 =?us-ascii?Q?xtnhYBZg2RTVj90mIs8xUnGZNQKRgSXseGF3LQKR8ECf7CBIzGqy3nh+qGKz?=
 =?us-ascii?Q?uWG7vVja2WEGuVToKlxZZALbpXA5mNkKq4FBtKf/NNNIAeJX2Sm8SikzBL+G?=
 =?us-ascii?Q?ughzdqdiPM3WCTOzUTCoxo0Fr4UESr+EX4HKVETPzDfXBsXdclwPkvFZykgr?=
 =?us-ascii?Q?MMTGur5xiz1x7XW/+LfZf5fsKZAHMAQTnd8a7B55+2PLtrmFGu1qBP9LSgEv?=
 =?us-ascii?Q?b2dj7wqspZ/mToBhb6j9s61XodbF/CmUZHp+p/Hzkt+vc7hKEFR9avId0lgK?=
 =?us-ascii?Q?eYDhcwlXlyEqRElJJS4tUEdUTAmudMYlZRLaMfuXk6gf0zmlnCeDFmMcs6Yp?=
 =?us-ascii?Q?asHycvWy5BIDFJIELI96DcQ3WfXuV0BLilSBUaF5pl2Zvq1//hAVJpeumU1U?=
 =?us-ascii?Q?Mtkq6OVM3ehUTbPmJcxFek5xTMneJEH8PRqbSApQ2SYaLJ2oZaC5aJoForVn?=
 =?us-ascii?Q?QdLtHdjHcsIwygsOjGEuLD0TCQItiyalWfifvT86X2yKQoSxI/SUAIuQFItN?=
 =?us-ascii?Q?VqIeLrtO/2FY1/YFQX6NnM69ozLvwwhbeMNE2xDPL07Mab2V8+Khr5ieN+4y?=
 =?us-ascii?Q?M/2n/zJSeQ55jeCfryrjSZTUtGW/wYtchx0fdrZxKWXzRZuyrsTh4wyvMf7P?=
 =?us-ascii?Q?hd9dyG8Nrb5Y/8KEziK5+4RqzIT/KtG6VLzRTbTf/gdf4uXbH1EQsDvy8Edi?=
 =?us-ascii?Q?zrpqFEUViALpc6XU7dNytdX5T+LZwHxWdQJsH5ho6VMeb5T1aaq1lFUFI8yW?=
 =?us-ascii?Q?2F2cgbJdzagE2uNLMgOTMdu+OGgiNS0wlYvFBu7/XsjVsPxWWJSMK+TzcbUV?=
 =?us-ascii?Q?qHTiMxiv4ShMZlrJiDQu1zbXg0j3XhNMMPrFiasTjjbPxaRTekXSoS02PxnA?=
 =?us-ascii?Q?eVXM4Z5MQXvgtRsmXRNZ/Vd2DAE5pqkP5uXJTH7482ZqgKMvITBWxVGRCXW2?=
 =?us-ascii?Q?7U7MVY9hPnfnBlwp3k0Cwj3IrsV1MtNyHvgiF3iTh3KqyAU4GfOc2uWL3Nhv?=
 =?us-ascii?Q?VBNSa8R/HnYqr6WHId9a6OECysrhWGOv5S4ni/2u5ec0msIDF6sg6PjtG7lR?=
 =?us-ascii?Q?54ihelFmTY7TN3xfwd8GOCpJRFUAW97rNRj4d3AtIAWIt6UMWI6bPaaIzqc2?=
 =?us-ascii?Q?cJZbBEZOyN1C/11qKkG/hNvgSrUVLAvSYqJCdl9kNNyymNPUhQO19Pn7Ib70?=
 =?us-ascii?Q?L0UoBmHC56dw2USNBI62d/FkFnBjMEFhRcZoqDaY4jUmyB25RM0GjbzqkSBf?=
 =?us-ascii?Q?I+IEir12AWD3C90p9OyesoQ/nd9Xvng/oc/LM3zY9PwDb0wONQG3pRsZJgaW?=
 =?us-ascii?Q?RerCADMkZgMBf5xKyseRLHCmNjWqIsKheNp3K7GaUNGMOvfqsbwWoR7iHofz?=
 =?us-ascii?Q?+bQe1wRwF+rqrjhm7Elxv4tX/1Jc1sDAP1yactTiMi6YODSdqQiXz65x1AAg?=
 =?us-ascii?Q?90nwuumRB3iCPDE1336gk1S+FmmzV5TPxXHIK9O+wRKAD8AwFgmyCEFYn0ud?=
 =?us-ascii?Q?eTxEPvhx6X7lCcDd5FsPYzSOSGzpqniWHciYnTxLTJOBMOVlYNa6K3Z4x80o?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3350582c-0af6-4c41-00a4-08db02f859cb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:29:48.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWf/4o5ZI/kefZXZa0hUYmS+IR5CKfTd+iPztU7aN5qkezAOignkQr7WECtinXxqu/Z719zKGdFweRPIgEaFUft8MShFi12SSuq9b6xc9js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> the timestamp after every Conventional or CXL Reset to ensure accurate
> timestamps. This should include on initial boot up. The time base that
> is being set is used by a device for the poison list overflow timestamp
> and all event timestamps.  Note that the command is optional and if
> not supported and the device cannot return accurate timestamps it will
> fill the fields in with an appropriate marker (see the specification
> description of each timestamp).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v2: Thanks to DavidLohr, Alison and Dan for quick reviews.
>  - Drop exposure to userspace.
>  - Drop prevention of raw command based access.
>  - Check for a Not Supported return code. If that happens eat the error.
>  - Fix missing endian conversion.
>  - Switch to ktime.h include rather than timekeeping.h as per comments in
>    the headers.
> 
> Based on cxl/pending as of today.
> 
> Open question: Should we only do this if Linux has control of the
> error handling?  In theory it should be safe anyway given the
> specification is clear that the timestamp base should always be the
> same - so subject to small errors we shouldn't cause any firmware first
> handling to get confused.

I think it's safe for the reasons you give, but I will ask our platform
firmware team what they think / give them a heads up that Linux is
planning to do this unconditionally.
