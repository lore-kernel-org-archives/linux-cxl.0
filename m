Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD548C636D3
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 22:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBGWbC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBGWbA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 17:31:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238A13DF3
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675809060; x=1707345060;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OzSlkXUKkvqjkqT1HiRueNBw6g5ZFlZ9qlYazxo3blw=;
  b=S/3WzNL497xqdqwdhP/G1N0QeGJcJ9GCBVm90dxMkycKHk1fVWH//rTM
   I37uXq7gszGjErArJtYb0esHuz10xx6rpMEpmPidu0T/eEXZ90Kvpafyt
   0/WfW59mDprJpcK0xpaQOPJbJEjxoX6q/xZvg7EWoant8/BA3OrajygKO
   lLz8n2WRQL6NESSkwxce9wTfOh6UbBQGxya+O6pAy38KiWDD+OcISbTfm
   ChZzFV3gVNmfW/I7OvDQkLk7BZ6gVJBkE8hlIRdB4HEejngvYVpEwnHtS
   iCroJM5TIWRDgc1hGHfHdZmON2zmUm3cIlGQXq3GBFr2mv1JWyKnk7b9W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328294858"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="328294858"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="667006597"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="667006597"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 07 Feb 2023 14:30:59 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 14:30:58 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 14:30:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 14:30:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 14:30:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1w4X3+41dwRiShnGbrRrvhjDU2lP3yOfDev2PamUkSX+E3UIDEfKFjUWSrIUopd+0rle98vQt4SAqTPdWDt4eW6LLYATEUi0RubAqrX0kdLGPVvggGt9TjQP45vwZ+NMHrPUnIbjD6QHzV3POq+EiTewrRZTh+ncSo3xO3a/iYBUzw2qx1DF/UUUlKCY3ozhBNSyE/Ow1p4Iu7db4UMqDyWSbtDHbOBxsaimA/kTHtca6gEhfPjwdb6wf3gQKbdOtCxlJWTKev6HfS8d+V0zjI4ngzwthDvCuZnv9JFs6meuKz8ufKKb2umOd++1BRuVvR2UYSkAlkGRC0m4Zb9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYfhSrAumdM8LMAB72XN/XEhHugkCBiB0C6uCxo5Mhs=;
 b=V64JkzJrBYEG1oiLrGJ+fQAfCDzuTQFu3DyE03+UU0GLtcX/3NXtP8wsM1s5o/iKNNpPmXaMbaBd1BsRmEBojqAnt21CqWKriQ47I91YMsCfYb2Hqfyjj64R8KfAY8rHgCqgQTfbX5u2Vacok7slpFxxmw6WvPXqr32DY6WH2AY60iis4cAMCOy1266zFbQIX966jChTABUv26ofop1vVujfLA35kFKnAqdwkE/4tAFJ2tRdKYNZL0rgv9GJD0+vBbjW+8RocE6EBym/XCKPAmLK8CTx+hi0cR9Pk0zdQm+AgDNy5wsW9E2BdlNZ4V6WhODkwFGJcSIBl1zi5stAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7331.namprd11.prod.outlook.com (2603:10b6:208:435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 22:30:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 22:30:55 +0000
Date:   Tue, 7 Feb 2023 14:30:51 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 3/8] cxl: refactor cxl_hdm_decode_init()
Message-ID: <63e2d11bd7a81_e3dae294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406532445.1455071.11912469846849312756.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406532445.1455071.11912469846849312756.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e61ef26-1f7c-44d9-950f-08db095af9dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QE0Wd6RJCx5EzPI25zXL/ERJI+SCsj/OMUQwbX2B/Q30gyAfHMeFgWwBG9s260yeM4cmxLxZ7EZq+YGMVpk6RqD+xZhoLSds+F2au3jMPW+ciyPs827qj6Sg2Pb9fFzM6WHLsGmZFjgA1o8L1sw7AS4XNSxyM5ZLfx+dgf2Ikx2GUISrlJjtTBZcBFAJ3s+e6pwqvvmuziyPGeyrVfC8HjxxC7r1x5La1lbG2eMPvJxmDgsGK2u1p2oTlqZi5OFSAaPR2SUEvYy6jIOzGFzVxRRIWgz2zJCJUwLQ5txGQV8VFNsGYrvFGuoXUUuO5+1GtLfn1DbFtIx2lHDETigH5m01I2VIfyscWDiH1Ka1Cod9aItbfYWg74fXnbVpl3EdFbj6kFdr6ppDZgiyR9B1n9/AU5MHpQU3NJI6Ynlz9naJp+sOdVh7PN8pdIz4UHif6Oslzzwz8sGqw/sYV4BhDeA/fXsrNYE8JEa1si7Fm+YrjyfxFJnkQZyGkNEMn0OEmu6RtRsH/LHcR7ctkHd/qFsNtvh4i+UwIRcJzS5XiDKkitTVuBTiK+qTzKsgSLnzhO2vA82wEdxTjgYzK3KHYWyHe99pQAq0lo8pwy2fluMpEubzYsvKOUMkfGkSChNgvS1zC4lyRxbEeSiYW9OwPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(86362001)(186003)(6512007)(4326008)(4744005)(66946007)(5660300002)(8936002)(8676002)(66476007)(41300700001)(66556008)(2906002)(26005)(478600001)(9686003)(6486002)(6666004)(6506007)(38100700002)(82960400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vPy19fPbVitwF3WhRmw3PtbdTSacvbp1g6vTWdHn3AhD0TvNBhqv6Le+xkkQ?=
 =?us-ascii?Q?BoGh80VKdv0oIZvnBj0i+E2i8ZN3sKY++CFa8wRvBmmicSx5sYW22XvBqVo6?=
 =?us-ascii?Q?FAXQ68jMJg+AK4zqXpgDw+1iCDuIZbCjSjUBJIPNaTdMDDj+VFcdwvjfzUiK?=
 =?us-ascii?Q?4ApcuLjfOXKf28p2zCdZYc6MjFf5sNNDruG3xj9MIr2oRou473q3hhGnR3VT?=
 =?us-ascii?Q?PdCT88OEI0pCj1Zk6qF97SwHlswkz9JxvAyBDxBRigaUkr+GkSm+hQ3E3ANc?=
 =?us-ascii?Q?JqDSpvWUlW3M79WSmNS7NQS/RzWNRdOtcz+l+FTm8ecTM+25somW2xYA6Xe5?=
 =?us-ascii?Q?GYAZG/eqqlHR+KW/Lc0C7hKCm3Hazk8GkgPd4pKbH/jwr2e0AcSYsqRBXq+/?=
 =?us-ascii?Q?2I6JWkPkaKCXEm85WrwPI1qKAsjnetBy6LUGhAYRIh3uLkjwuhc8alo1bkSf?=
 =?us-ascii?Q?unlYGRhMeexyJfwpfKGIBZIzCZCOvRiIbgVE3hbde6hTfx158HebtGpbDXKM?=
 =?us-ascii?Q?d05dHZHQmMj3EyzwSm0/o+JbL8DXpgzt/r66H/4JPRY//TIedzSNc0vhThl/?=
 =?us-ascii?Q?Q5kvsyz/bZRXyAfUUfEHbaXAWiQSExIcqFsd/61IUzuaJ4wemVb2LSzrEDej?=
 =?us-ascii?Q?Pg2ehbe82k+XqkBsjG0Vprz9BfVAn0v3TuZQoIEIuCM+yjpCVxMjCJn5Zn1a?=
 =?us-ascii?Q?Oy2ZsPrvGCSzf07SuXjAYP5xXys6hA7OMmUeqqaM8W3cYzu+7xjGAO02jb8/?=
 =?us-ascii?Q?SiVdRKhYJsV0FQHaES2H6jSXP8gLUX/xT7/IvBXsUAUa0xB07fFqWB1F8RwV?=
 =?us-ascii?Q?bswjFkRVqmm88bfR9RFT4MMLKzwwlikbCdnP0JegNdEPykr6SglG8HvNQfc4?=
 =?us-ascii?Q?k49Zv1dklEjGCY2ea8zkg9goxQVzczFD8qGIlBth28GRLcgNyxQNWKcPD83Q?=
 =?us-ascii?Q?Ft/sELo4m3OZuN5JqGoKNHEz+o1NC76tRkpAMcBnBw6isWNgsXqclcyRqC9x?=
 =?us-ascii?Q?A3D/+lMwaT7TkWw17os4qtrG+5acRnpJwC6pxPrAHkqPhg20Mj3zZDZRf+Zm?=
 =?us-ascii?Q?a6ccWVJvgTngmNrwr7dxuj6GP8eMI47u9xYJbb/FhNkQarQf1RRevyfNbUWt?=
 =?us-ascii?Q?waCaNG/0ykGxLaM8XoANDdM8S1Bwb12mQLYytAIpXAFVG8AVC8V8myQo0mM0?=
 =?us-ascii?Q?47NOQpf40HmTd/eDjlMONrQlyzPjZPmln/fLW4xI9IjtdY6mSow9aop0c9gd?=
 =?us-ascii?Q?8X2BOyhfOjd2Nvn9BmYSpUsTvqEAg2W3WBz/s/KSbcHpR477YkNLe0ik6hOD?=
 =?us-ascii?Q?YkQ/C3fCsvwh6BLfXLOTzSeQKLJRiSm1uGdT2fq7FRKcbmMqwlfynBkXeSWy?=
 =?us-ascii?Q?+g9yQSry9W8A9KCwOOH7ztLcAWlLiXj7Oe1eGAHYUQvnoZokcGwX9s4mm5lN?=
 =?us-ascii?Q?O8S3NgF+Q5q+QL67Qw+Apx5KvlwsnvGv0o8tn3WrTuSMyv+tVM+ze2R0hibu?=
 =?us-ascii?Q?W+o6wJhpb6qS02x1dssZ20ow6gRnmRbt7plTCfC3jIOjhjSMqUXOb8oENtQ0?=
 =?us-ascii?Q?xfn5XAxUOw3T6MPbS9K0IdEfJD9GMrWW0QTkq55AMOycjtbmkLAn6hV+rgU0?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e61ef26-1f7c-44d9-950f-08db095af9dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 22:30:54.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w0B/2lFXdP8oCB0zIVAo9l8xKmf23vNFqL/dZhfYqW7YvqIvtSy5rFiqnjZ+gPj8kjRxh7CmZFzVr2mNTL12TjFzdCHebO5QfbXjDko/jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7331
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> With the previous refactoring of DVSEC range registers out of
> cxl_hdm_decode_init(), it basically becomes a skeleton function. Squash
> __cxl_hdm_decode_init() with cxl_hdm_decode_init() to simplify the code.
> cxl_hdm_decode_init() now returns more error codes than just -EBUSY.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good.
