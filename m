Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F6CD37AA
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Sep 2023 22:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjIOWMA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Sep 2023 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbjIOWLt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Sep 2023 18:11:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88162105
        for <linux-cxl@vger.kernel.org>; Fri, 15 Sep 2023 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694815903; x=1726351903;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xJ98l8Ptis6T5KrcexS/f4DbNzRdatbVoWbowdz4b3g=;
  b=fxr0DbcejXVnfzcOG3GqsJmvIj0oc3cC3E2Y7FxlZmbni0DJWJro6n5U
   +K+a2SH32Jg8UOPyY5Iv5a0HAkc/rS5mBArQYxpfZ52pGrNApyXVC7RLH
   6YRdJ9CN+IUslkVDKdtr6y8jMujElfbdoJFwH+1/JOghh+JQps5I5yIdp
   rJDfgM0ay4ufLFxFFOGzPj71UbxRVmYh2h+/fVY8Kht9llxW9uyx3W5Ik
   +qHOY0mL6VsCJnmebmzWYNvZUtXauDB1R+l0HTB3sLfPSwWEe/T6jcsLb
   vwbtvUjGupM8Pr0C2cUUi3DOMX6Br4CwjITBKaOklF2amplRjf7cA/pUs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="364403190"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="364403190"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 15:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810668121"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="810668121"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 15:11:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 15:11:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 15:11:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 15:11:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 15:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aScjxfYQId1ccmj7QHFqpcv+vzkbHOYuoZgcRp2CipaG2M/qKNQljBmXTFRSQSs0ToyDMCLGyBrSk6zlNwzad6hq0G9CQ7k82hq7Hdb3XPAxkRSGIRP3brAuqFfxChYkTMlkqDktNYvwXS/HlDo9Gu7LilGoZW0wZSaw2HI3boxbkoHjQldzB7IRGsYORhtJfem7G7H4yuI5TjcJIuufWuWnMDkk9Wd9U0ZQDyv6rWm7RzOVF7KU5W5hwNvmtzVbbfvN37hOHT2SlfhE+fZF/i008uqDsDRAMAQrrI3ZO89jDJbGO+3s3iES785BZnSlddE7eReBaBcn3FxSNQ4Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4gx6JTSQoCS3vLv3igzoiqPsC+0jM3losxH7fam0Z4=;
 b=RPQsS9hbLdRhznrZtm5mEPhrP4KI/koZq4ZlzpadfzmJNxOhcVZ5f2o2m+ZLGhx3tsTh/iDZIN8QLyEI25+4du965QdgpI+8LkjuvhHL87ftrC93cgOTBymtaPrjvgTIT8QnVqiEAamSwyFVszeyjOmQ7+Nt1dexZ/UrDZa8SVZqo1GBZetQAXy/u09ELCvX6iZHqHPL+i7jcYOuZ7luiC6jvdO1R6jaenN6taSLhwajDntBF0vm7ov1dJTupUE6zl7sH6N9tvdWnLk6abwjSZCIYTd3GmG3ptBgSCeXUiMtDuAkmI2jt9y01csdQHEkwvgFoVgCGfJTPEv/vwupcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB7350.namprd11.prod.outlook.com (2603:10b6:8:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 22:11:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 22:11:40 +0000
Date:   Fri, 15 Sep 2023 15:11:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] cxl: Move command enumeration from dev_dbg() to
 traceevent
Message-ID: <6504d69a10453_37d9bb294a1@iweiny-mobl.notmuch>
References: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: b60650f9-334c-449d-d3d7-08dbb638bce8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXQ+AYfMDgPvLX7IGXTf4bPrMP3wQ06RAZaaIUKuULSLuZEaArmTXpq+etwsye5BgwTFzURNHSpK65+tqONceyqG1eI4OTrrx3qd9KpZ81gr7KkH/9kbfPhCXXIKnVkZd/pl/Liz9gHYisf1bvZcKzu2e8GTVII1PWEY3Jo2/P8YJFaJwWTI0A/XwWUpjlIKoxz2SjMxA4ADSdoD37GNn0lYVAU7M9ooY5E15dc9Xiui85mIFXr40DkoN40UnmFnD5ZXM3pFohJF6nkCrtigZunyOOG8WDP4VDS92orL0RblOloeeiKmRCS71xirJmt5R1v0zVfhx4rgYu/JkWZk3JdB7vLHLSoyDIeBmOLYvSvpqID+KcRxPi5oQ0TYJSBFbnwhQCq443DLB7zggIDJgqLV2J5H7J9vNfxAfTU/pegDMI1La7LpXH2LStzYQ4MxZyX2b50laOZS/KAuHuYKQ74/ANCM2ecJu2mwNDz9bZ5MfgaiMP0o/OhMm4OT3xsCsggigPMARtjmAjK+xRvHojrkEO6w24earEaePR2VVX2ilF1IX94jIo/PwXM97kCd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(186009)(451199024)(1800799009)(478600001)(4326008)(8676002)(44832011)(8936002)(316002)(66476007)(66946007)(66556008)(5660300002)(41300700001)(2906002)(86362001)(26005)(107886003)(38100700002)(4744005)(82960400001)(9686003)(6512007)(6486002)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mfaNVC4aZJWNiXlVbYdjPP7VoWmMpB8g7wtx+wV/KLkf+n/lPFtoXH8Hlt7Q?=
 =?us-ascii?Q?xx5OCezZCxLM0Y47LpU3Ji/tYDwJGsCzC/lmODLsW3JrmIu4xsBW3bk6vNbt?=
 =?us-ascii?Q?TPbYNplmq5jzj7X9DbNDdg3iHvWK5lyiZ/Z50dO4DVfkcsxckuuk6/hLvpCu?=
 =?us-ascii?Q?Z1uXc7KwmuRd92MfEP40OLRpezOoPm+5QOhtxq2EsI//yoArkmW+8DDIZ/HK?=
 =?us-ascii?Q?JW+9HnUGUPDvR3x0k/lBl1wR14fGkMiDrdfK0Sf00BTYmzgizDhFz4zaWrVJ?=
 =?us-ascii?Q?cSYOCY+flM/sSAgKwRSqugzxsz2CYivaILQ6c9SrVCvF2/bV3z49pF91cD6b?=
 =?us-ascii?Q?+dF8vYDOsQuz5MjkSbtx9nq+bKVSmqbOpdDc4RiZnAcLbVCkGK/86GDzr+vf?=
 =?us-ascii?Q?LO4s489hzKci+obwLtHhjH+CtDlsmUr1JaetnAk5MnLhB1BjsIliBx2zj5Or?=
 =?us-ascii?Q?VdgpOySvbjU5wOZ5TaBvCoZmHhPpMvaTBrwXkTrPi5Kabcqx9h9Q7Pc3kqKe?=
 =?us-ascii?Q?vmda48rEBW1/bmYVexlne0qlLzsGLOyNZcpMdk8YFjhIBqaXFHVmAeLw3WMA?=
 =?us-ascii?Q?KXZoRGcsB6NSV36DyTqnh0FOK2ZlDk0siMQVCR4B8bkiyDHXfHg+6wk5N5xR?=
 =?us-ascii?Q?ZzR5ogDYBQfPYP/L/QJQkinY3CpokQzjP0yWPtTdZ+riizhUWn1oNnuLhTBL?=
 =?us-ascii?Q?Fsz6FC6SqY7Ly72FOi9hImmys0LZEIx5hTEk0gnoBDZlwB2HYRb5rjZD8gxL?=
 =?us-ascii?Q?/LtwdSnXKieBGExzIE8cqHBPxQ2b1Nksl28zbaWzv8EFwbu5eeLHTmNtEyaM?=
 =?us-ascii?Q?B6hVOfZycuu7JwHc7CYklsFDUOMgT8SWkQoCfHXN8ncHheUZ1iHv4FXJD3Kh?=
 =?us-ascii?Q?DnmcZCVhF0EO53amRy6IMStDVtrjkzMvJtkWGkZiFLnLMnoVCXTqF5auA03s?=
 =?us-ascii?Q?z9VGbmeBmaz+uND6sPk6lYrRmX4K8ZPcPXVKhcE1a8+SHyFPTedeQ0rFY7Mb?=
 =?us-ascii?Q?1t3eVI5ca6LbvrqPGdtGKBeqoQQmFNro38srSxAKQImti2KemIvitaJ0XM70?=
 =?us-ascii?Q?m6FvuPaBPT+adKLy431Nd8oO4m/MeBmF5freZZaod8k2+67YjLjYitDz4/Qj?=
 =?us-ascii?Q?FXctaqq2Ki/4zKnzWFy0hmmjvqZNffcIHiHbabXWN1xecAFnhOSkWwKerg/Y?=
 =?us-ascii?Q?qtkDhyTK90ONFs365XQxOfOM1cW72g0tTKxv7eX5rmIbEa0/ujW6ZgVVLlsN?=
 =?us-ascii?Q?wVnBflS1AbIhmwGmyGID7hNwcQ7Hj0iMdA4DUi6BtXtvkraXBdi1+vFxoAYE?=
 =?us-ascii?Q?Yen069F+TntRqt1cI66fida01lcLoAL7y4z34kYv0Jx6bAF7defHNu/P9MFo?=
 =?us-ascii?Q?3/p0GkSZ3rLYDJUpi0B3ag52D13M8dFu8liQk/k5UYq76gZEi5oPMRz/LOZ8?=
 =?us-ascii?Q?FGFB5T3Y2dWe8DdIpGLMNZWupLSUjYReVwDAjOKXkB+AWajyhDaImOGrHqWJ?=
 =?us-ascii?Q?0JTbBbvdgvDFkrye6kNjUZ8gyDk3snDwqX8hplRpG3UA/RtwWCnEtegSIhHC?=
 =?us-ascii?Q?BNnKD2/wmBmhaoHJ4fzV2v1fSnFwDfXTBZ66W3gY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b60650f9-334c-449d-d3d7-08dbb638bce8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:11:40.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: You6IrTJF7qNOtxeHR4Stb0N3Ocosopfv++D7whJousd1SgpknIVRiCf5GYC3xzpQ0Ha3BJotJSevhLV/elecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Given that event logs outputs are all emitted to traceevent, move the
> enumeration of log types to traceevent as well in order to keep all the
> outputs at the same location.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

My gut reaction was to nak this patch because I'm not sure how to enable
trace events prior to module load.  Then I realized that this is in the
cxl_core and is only triggered by driver loads.  So I've not tested this
patch but I think the following sequence will work for these 2 patches.

$ modprobe cxl_core
$ echo 1 > /sys/kernel/tracing/events/cxl/cxl_log_type/enable
$ modprobe cxl_pci

Is that how you tested this?  It seems like a pain.  But perhaps that pain
is fine because these debug messages are not as useful as others?
Especially for all the unsupported messages mentioned in patch 2?

Ira
