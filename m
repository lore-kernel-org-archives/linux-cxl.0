Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FDEC636D3
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 22:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBGW1S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBGW1R (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 17:27:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155A1352C
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675808834; x=1707344834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SobdbIHbTs5dSeKsnVHdd5inR0bwE6SHkMnzENR/NJs=;
  b=Gn0P3SXorD7B46FAGLZUhfQ9F4Fe0MLa/uzmTyKFzhn/sKU1uR4WyjqQ
   NqkxleR7TiRXGdrZrflEMIUsLJUBsh6FAuoKRm6VyMc18c46zfkR3Pyz4
   0ctVSPI6j0uxJd35Vz5BGzRlmrcI1XUFr71k2kIg22ShvLlcegGHTODHh
   6mrtHfUN/woZyQW8MZGf/+KXo44ZcGc/j1+uKyxsx3cPz9gfRWKBOTICC
   4lmN90QiyAh/kNBRnGRwb5J+l2GiHacOliYMIhp3VcCom0CHAeyezE80K
   c0RcsZL4Ju2v3gf4zWEInyXJl/gQdx78k/2/yheLDK4IybtRYYuSsHWnk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327337711"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="327337711"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="616976264"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="616976264"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Feb 2023 14:27:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 14:27:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 14:27:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 14:27:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH86k52Kejq0KsdcRCjXWL+wZef+DPy+ysJGJzXLy+zrushv2lPtbeUMsdIAk48Jhpu0R2gH8ZBOros3YegLSnHCKx7yAo4zvDl77QptoPisNFiQ+c6PLPwLolWp9gtDHBRzzED2uMZLa1rUp7txbO+q1VeCEoB49o69NH2891eQ/AtK1EXQI40LQQNlu5WYkPZ5KnX/t/mDo4ECZ6V+NDO25EFf3pHcWsp3qUtdnNe1B3bPiiscjI2cHjbhl+eeWV5hSr6FdLmx/eFjPUIYMxhTclYDgpIhiTqJsnPAbSHWteBPH+JVuEk41gFGrDiYuDgs4U30rvAUKLyBRDygMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwQtZVuK3DNHwzmA2jjcZl4jXtr3buegDSPQ8OZO6i4=;
 b=WWHXEMgmZW+GZD13R2VzB0+qtB5bpApu/2+ovduQZuSo+dfDO+z/lOxWCA6oAyAnAwG3EgZgomSDN0geW5RTj+coiQQY6ypcVG1HaxE6f0M1WjsUveqhvbQAlD6p1kZmiwAc7iEzugiOFnIgW1md2jeSsrONLnOmuX0kuDf7xBfffPaxhIj9u92LKLlrcXcFf95WIUOI2OexR1PB6eiBQVN/7OfGe0D/klAn+ibXoD36emu+z88hRrTWZM9OHz2G5bqP2fkDgvBxym/UvNqq9Ch7vEZROTK7Pj3E6xtoGsllLaOoXpobsGdsQiE+lxm17510BLpQ+0eYL4YrYpnOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5570.namprd11.prod.outlook.com (2603:10b6:303:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 22:27:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 22:27:00 +0000
Date:   Tue, 7 Feb 2023 14:26:57 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 2/8] cxl: export cxl_dvsec_rr_decode() to cxl_port
Message-ID: <63e2d0316edf_e3dae2943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406531610.1455071.16749242105523531268.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406531610.1455071.16749242105523531268.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f2e736-4eeb-431d-6a93-08db095a6de1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrsVFlCGxXSRDWztANWrXQkoYb4odqL3r6+auHLJalim7oaXNrj0L+TCx/KQxZvZp/qYTw+1BFX+TL27JipJuHABB3KRZOVuEctpYTVUhxAbtYEw+Fz65NfFfemo/fxoRDHv9SzmBrhfpF0RjRU5paSOlVEk+EOm4rckvoTAYAJUrgiVbSANJN2uZHpoxJnEIX1Hnf4fB07MnSKj41KrgVxSW6SbRnTRpIZfI6beYDUMBhANjYn77jtdnxV6LnV+SlNy9fVx07gauKbM5ymaIjNWkXhQ9C1WuOQAIbvANwouejfYdOluLMqcG1dqhGBjhn5RJMxTMs9tIEKXuEnxbawqDlmtnZTNPTA11J40mi/lLj/lJCuMI/wRY1PCWuWOcxWXVhnEFHejG4As+3pPtgtYRQkGbEg2oHlxrzuwkN5vRIIlDe9lKpTyDEMS8uXiSTZOVryoyMrDM440Z8VYP1JCupbj9W4IK8QQLLdapFhKo/B8+mQ7fhjEK/gPl5cGRwIDsk34wXl4kcuuT6YrPKY0yt0hgChUBVRULTD7z//20Tf+Fr5lh29KdtAgEDm/cGo74Qj21pvjaoEq6sYSWUa0zIXixsNY1cCWuJE/7hOwcGV1raVBcWVv+FkptSAw/zyW21N0E80QkcxmgWk3dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(9686003)(478600001)(38100700002)(82960400001)(6666004)(186003)(6506007)(6512007)(26005)(8676002)(6486002)(4326008)(86362001)(83380400001)(66556008)(66946007)(66476007)(316002)(41300700001)(4744005)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SM6mOlTGUOB6ITI/4lpEvtDZArLob6XPetvzuuafU6zc+75BHQfPcbnLsplF?=
 =?us-ascii?Q?L7k4kszNaqXcufPYwpcbg+oleEV7i82VN41+kn0oEl7IN1xcsOnIYuMXHL45?=
 =?us-ascii?Q?XGNwuP047Hs5GaEWTLqU1N8r462qlw6jzTqQ15+yg7HuWzBNflD3wrKBPSxQ?=
 =?us-ascii?Q?UrI1ijIfRFrFawcoHyhS+KIC85DEmFetx1bPHeaOpIYugUQcwbwt+RYNS+Tt?=
 =?us-ascii?Q?dyAQHtducwxtw0tTusejWWo6hPGq4XLuA8NRRO1ejlpmleJAT16rWelIL5eU?=
 =?us-ascii?Q?ZOWD2sc49S3dpKHjPK/LLlnZtKe5I3Or5cfLNizvvOECaxVuIxm21h9+vwTw?=
 =?us-ascii?Q?UX7czonqQPlcVvy9cU1YF1vcJDLnvMeIgd67sIzL+XUCdKjP1cE9QOe5iSXb?=
 =?us-ascii?Q?01YTGST26xsrXUEM9/DNDF3IbW8nETqXyJH07ctoGTLUoO3QY5D4PSmQIFXR?=
 =?us-ascii?Q?Wlovn6jb+2l8n2tehKo1SxZtMORHADODl8wi1WbV8QuthW8xVmpmpjZNRun7?=
 =?us-ascii?Q?mueTDuE+ef26DGBnd5ukG5RuOOVqwB3q47eD9DaqoYGJ+AvoL0lj+nAoanz6?=
 =?us-ascii?Q?Bww5/chGOq76zRMxhZNRQUaZ6aX7Lrrw80xNloSzS1wgrPeCdBnjRNBV6Tqc?=
 =?us-ascii?Q?7aVsdmjCES6VE5M6dY1OOKnItr5jfK+td2xNRFMCrqtTJy5TlKfBzwAqvIJ8?=
 =?us-ascii?Q?Kx0I6gwdiOaoA89aKv3dalrmQQOe3ZNRhgHynrdnjtO583059SKwOMNcp194?=
 =?us-ascii?Q?+8s6e3s02qoR8jhlY6lqq8QDiTJy9LmKYFbq4Tskk2hkM0lWiOnVhxAp6Npo?=
 =?us-ascii?Q?tIXWxgbVy+n2Bzg8/JfQCIAmwoCOasZCj8iEIbvssfSY4jNrUrw1s8ttVc+g?=
 =?us-ascii?Q?LYyC30Zos2lEOLi36ZdmoikKz8dZTvqqvOJFAdMpQsBgdcIh3LXqxL9c49aC?=
 =?us-ascii?Q?qSHg3XZeDYuWvjxI5ut/QbeUTqoeJUKyapxeXChd7Qa/9/lbedZI1N6jJMnB?=
 =?us-ascii?Q?6JjGKPoBgEaTRFZC3H6WQ6HJzNdYVz8rHe/e7sTdg+erdmbaFMPiT3SZMpea?=
 =?us-ascii?Q?ty/DmscODVCbXFeFYjCj5XWIrtUZaw6/0ttxaIYkPRegAiMmjX9O6abHhsPT?=
 =?us-ascii?Q?8ihnTiVkyW4fB6utj3oX+1MGT7mDur1ccq8BUYV/qN/qzIOUUcqqk6OlHLrb?=
 =?us-ascii?Q?JiXj1pN3N6t7vGc7N0Zh9CMg1d5Mw/EgSCun/Od5ylrQAA7zrmA2LZkYB2YS?=
 =?us-ascii?Q?81PMfVS3O7vIfsgG58jgInRAzK9Z/taQSfPqK5/eLSf6wHharGzZup230rIy?=
 =?us-ascii?Q?ZNoWK8f/wrc9PQVS+EHBj8D0C0XJf//qUGgedAU/T6EHPs1OzjfBtrxzzYsq?=
 =?us-ascii?Q?qnjtp6E8y9za0bFoQdvxhsBwGINxoyfSET238Mc2pmR7TGPedjLJum633Irl?=
 =?us-ascii?Q?10wGO4C7oS/e3byhjVjRmUzVr//PoAA99d4LQft+G7Pb9OZpRJhen7XI/6P8?=
 =?us-ascii?Q?uvfrfGrvDaWwblb0JzovTm/cvZhD5eBqD0l6JZjRtkHQuLsyw1gkSl5JTKQk?=
 =?us-ascii?Q?gvwIZivdl0ITVz54MzCp33SEfFc+/CEG5/fyLMOi/lWeXzrHL8l4kRb3VzPd?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f2e736-4eeb-431d-6a93-08db095a6de1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 22:26:59.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvIt4df3l4rXIy14Mq7MFxVri+IhtFWJmbcExZ1GGdHEYUuqCPfTnRz7WPoP1h/o5YG/wbT0AL/hkw5xV38bYXjU5oZj5fjJS16DtyLbTgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5570
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Call cxl_dvsec_rr_decode() in the beginning of cxl_port_probe() and
> preserve the decoded information in a local
> 'struct cxl_endpoint_dvsec_info'. This info can be passed to various
> functions later on in order to support the HDM decoder emulation.
> The invocation of cxl_dvsec_rr_decode() in cxl_hdm_decode_init() is
> removed and a pointer to the 'struct cxl_endpoint_dvsec_info' is passed
> in.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 

Looks good to me.
