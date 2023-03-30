Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5FC74A5B
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 06:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjC3Gdb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjC3Gda (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 02:33:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855795252
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680158009; x=1711694009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EFD8kkzvGjMK2/psgJOrgFBEl1Xx5oiOZ5NsP7g4oPY=;
  b=NqnYCTlQyaxV4Jp7DKAcHgVCkODLWyjGV7kku49mlqnHrMw3lKFBvMew
   g1mIy0PxVrO/Xe6y3TkC+4uHEvZJGOYvbXp+m+QiX9UzeTVdyQiYu1iS4
   fT+KsImJScxJa0YTPfB24Q3jBGUfVZ+3NIiWHHi7Lgtrh6h3v2UBxZg5c
   /RLptm6/msx+lqY9c+31Rb0oyNTOx7cS/zF7LaQk4Wbkdm7inAB2bfSwB
   jrsV+5Au9k4K9ssNIzYi+N/yHQ34aYGFbN8UMZfnptnke8jcPyRWxcDhM
   uUJdlUE3rN42t2dpQp6SuBQBiSUda5hqALPqXIvxsjX4/gJzUAaMgU/mS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368862238"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="368862238"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:33:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="661884228"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="661884228"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2023 23:33:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 23:33:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 23:33:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 23:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGHC/ML4IUjnVvrNCXTjcNOdbe6iIBB0WhuGZ7uQBy6lzer8JwV3FoLQiLaRxK1jOaU9i0jxy49VgK1yMvXH0CoGG0aBExsdfz2ENDxXeSB894VPD9l3klHEH/QMrLX+tQ0vxgBeMUUFaoRBjg/gwwfWITo+duP0UinUlI7sK0yAESFaQMh9MMScqsL3vFBCrihNp+MhUKN09Qc/slLQzpVcVYmWcmw1YI9IULkGZ1q7enEIYuUUMh8ESX1Z//1D2dgcdRRzFM5AMM/SAimGPXaDvOqsn0L9YUU5FQDsMHrgl/VODv1mkwG6ZbMIN+bifxCnKXVwYXjxaw4wWXWrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKGAgzwOTM9Nw2HGXFJA6r9ymCaDkqyvYJmtI6d65D8=;
 b=O5EyGlQNehoVYPd0YlRi/XROqVOMKb0vTToibTgsxuXuPsiDJE3m0OqVioVs42Sw1ADIDflKBEu3CJ6nMHDp1so+2Et3NNjdgPEzMwiyLReBUdYDpPCKMz5ZEwy+lRkGN+OOEeOx52hn9gENpF4NJp0/SWKnmi9GMbpZ0bfKCQXgRVreQOAOv3VN0qUyaCqg9REm5joYEBaYf3ApNiG8IKI1f/me+Gjwd+UShQYfZVWQDKgXIgMTPf5TalLX0HFKuEf4ZZmXVbV/ZlcT+0EUTACOWP7LvSQ18R+AdftXrnLHcR5HA4pcKklNrZBhGR2CBleIK5gPluMnZWuQ3mjaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Thu, 30 Mar 2023 06:33:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 06:33:07 +0000
Date:   Wed, 29 Mar 2023 23:33:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <64252d214f0b_c7222942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCRzh0VLSVF/7jya@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCRzh0VLSVF/7jya@memverge.com>
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd3e979-0ef1-40bf-9270-08db30e89f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjjTQOW1FdfXp3V1HmgwAM9Ub+TMQMWxaNiWPbJNS7APnEjIwJNIOsdKIFmgdX2FWA1hoHcCsc79ugLDGkfjRJWBysA9Iqguh5NIeG/sI8IFv/HUT3mwRssiK7DEFc+ZUXIel3JDBVwlVH5G2oY/JnOXggg2IMKeEJOr9fBGuEPsurcNXmAJ0E2MmMkCwAnhi+zLl30X5HmJpQmXzU39o550bixVuWAifJgTDaZ9PcyGY2JvFPlPGGsnJ02KtEymZIhPT5dQEfktGUKKs2rm1gec0mo/jl2Jn/KKJT8XxFLZkKOq9jSsiC8EWwJLSxmVRymsPWsO+ReL8lIkxPbeC7ft8knjWJNXbww1mjddrWp2SKK34S/POIcTAiQB+mvHAJucc6Wa+b0ftu9wzqHsbXFPu7ndgaAG4nI8fy5De+A6fRuRPpJWdjafS6ETuN3YyFmL3aIxp33nWYkk2NafIUVuqnOcpiGU6kbV37T5+Hrjusg2IYNhi1b/HFxGFZltsoBtk7hfOOn5LkyoPqOPZvIhmXyF2vAPAcBuFmb96bxhkrtTuODmTk9qBarUsaM6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(86362001)(478600001)(316002)(6486002)(82960400001)(4744005)(8676002)(110136005)(66476007)(66946007)(41300700001)(9686003)(6512007)(26005)(4326008)(6506007)(186003)(83380400001)(107886003)(2906002)(66556008)(8936002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8MQfenKyyj4V8FlOzd/vN9COkGoWMkDiQK/uCLXRq9Mg2JkH6f2Gk2zqbsO?=
 =?us-ascii?Q?9PTtvta1JgBprFngvm5KyDa/JfoARkm1rSx0ixVWj/wPMCoRQ27Vv09+1iYk?=
 =?us-ascii?Q?98kXYNeXOZv7CsvyNuocb+L6YXs+AkTADfok61YkBn8lW/7cgo82A4Ju5udm?=
 =?us-ascii?Q?+IWLuDzDBDbHFVFkqzPGHpbzVrcLkMGVT5xFjyh8MSuJpZaEwznfBHwbBpSF?=
 =?us-ascii?Q?WYsV0T2/9sDzdUKpvDsJII2rFhWSbl6ChlwtRN46+/+eYRq2enC+dhHAgu+1?=
 =?us-ascii?Q?nyuiFmO/e2wZA3L5u/tZEeIbkhbXdciBi4TMiHDZZEXqKLoROLmL2ORRcSCr?=
 =?us-ascii?Q?gC4j4DFMCYceEAJSw+8vxk1BQYhKNNvif9pL1Ba+yT1cStAyu7v/8ShtBjHD?=
 =?us-ascii?Q?FMmbcvXBnIs9Ra8LDZ5crs1wDs1V3fhE3QwjtJYFjFbjvwrhe61QzjGDZBAc?=
 =?us-ascii?Q?73rJD4Q/iTz2OVTdsTBCaMUgk7uBUTNk1i8SfrE+snfB+xE6jvEaqfaiYQKl?=
 =?us-ascii?Q?8UMLnJsUwI4fN7WtCA1Rl5ETuq2sOQegEoKmsOavqx2ju7bzmcjnu1XWPSEp?=
 =?us-ascii?Q?fGyU1GbpRt2RAX2r5+LZQO9Sv6GR7O/Pad0WQAKc1tMF+ggvBUAQt6SjIzbt?=
 =?us-ascii?Q?i1dloeYDqA6Rx6BsUfvy/UwO9AFoUxn+o3IDjJFh5d58MyX4bq4/gygCM5ZZ?=
 =?us-ascii?Q?tS+MSnE9d6pr9iNj+/qhw6M2bpL64GD52CLinLuZPE+iUFP88QpxBEHsUAgR?=
 =?us-ascii?Q?YW/+6GOmqYOmn466w0z3RaQd+KQ9/2DFCv7CbXxZAC1EXoMRsgv+OPSDC/kM?=
 =?us-ascii?Q?SFQXEC6X1R7f+CJFqWYAHuaVQhTJGRmaWktuQ1K6GUbkjkWVvl0smoe01CMf?=
 =?us-ascii?Q?IKm/JJq4qcO9j06i8B0CazfDG/MfIOYFAsPQzbFsBEzQKvo21vNfyZ6svLIq?=
 =?us-ascii?Q?duwedBuMBPdwkoJFDxAlacz8cbaVflUsEdGFz5gieCUl7/Fuysqso2QZhFx2?=
 =?us-ascii?Q?xVkP03wp0V6rDwdA+E+WLk1F+G3Y1QBRWqekqBxvEpojtj41S9OQTs0G4bwv?=
 =?us-ascii?Q?xMpYX0AUU7NMhIsqN/BJSROM2HdtP6rURXAaXddx+MkdUaHlOeAapcSVH2DV?=
 =?us-ascii?Q?ZVkxspGiy+M7ZITofsZSUKT8Mwh9yjlhHDYaGXHjkXc6bwbcqn01C3cc9Vls?=
 =?us-ascii?Q?lM2+xrsdDV8A3Og9ALsPmVvMP4i2PWN9ye47w8A/WkMRyF8WmjCGRzVdRxU3?=
 =?us-ascii?Q?RiGeDJq9rBilxo0y+00aIyl4kZfNshcYu4EXRt1omBOrZ7iy8thaUqXu5JWs?=
 =?us-ascii?Q?GuAooszCoYge//hPr1lRyFfF4DyYUwfkrk5llAP0+0MwDd5sQZEgeRgUvGhg?=
 =?us-ascii?Q?cYcKTQeM9Mfl4Gt9D0YuXOMX/vlECzycz06ggY7y63XrMDKv+LUSNs7j9eyG?=
 =?us-ascii?Q?8q/Ref4evB2Ps9YqGXxv2gIlxASy4YgOYE7wWE4bUoyg3tLX5XnKKhQR7Ebw?=
 =?us-ascii?Q?CfesfWJJrFG920YkiR4TuC5GB8yBkk5ThAmG9MVaoaKO/SULfcnlKBT4LncQ?=
 =?us-ascii?Q?5ZL6ZERlItoWsGFw1lUJDgW0EDFbY0wGpnfnz9UgGE97cIMoOwk41gQPua1E?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd3e979-0ef1-40bf-9270-08db30e89f99
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 06:33:07.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOi9IdY0P5wI09q7MwYSvg8CWpdVfQgX+1OeHusst1la7euA7LLt0svrctXILWLjAqP2NeVGMYOnenxKX2jz6wjn4hdHapUqt0htGcwMCSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Wed, Mar 29, 2023 at 09:21:25PM -0700, Dan Williams wrote:
> > > Is the DVSEC Range Register expected to be programmed by bios, and are
> > > not being programmed correctly?
> > 
> > This debug experiment makes me think perhaps the *device* is at fault,
> > not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
> > to set up the decode as expected, but reads return 0? That's the only
> > way that I can see that forcing that offset results in successfully
> > talking to memory.
> > 
> 
> Oh, i meant to add that i tested whether the memory is accessible via
> numactl --membind=1 with both memhog and a python prompt, and things
> worked just fine.  So memory works.

One other theory is that the device is correct, but the platform CXL
window accepts transactions at an offset and then removes that offset
when transmitting the address down the CXL port. So device thinks its
decoding 0x0 and never sees the offset removed by the host bridge.
