Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6969BCD37B0
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Sep 2023 21:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjIRV0E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Sep 2023 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjIRV0D (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 18 Sep 2023 17:26:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879990
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072358; x=1726608358;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NHaIbitmAZccG+0qmW+3iGex/ESvvpl485Q8nPMnDsw=;
  b=BChRSZkAbEJbELn4CvK3F7G6wmq66/QiXSdVLDNBeY9U9DgL+o9MhNG+
   AIqlhbTGkTBkY10WO0CZ6gzWyrrWAlMfwxqdzewN3HLQGI6euQIZuiaGj
   4qcTZFCGXJxdQcTtKQ3C2zY+bOmPwmHmqQ1nESF1vmoLDj3aObQOXH57M
   /c4Im9Z97P0grKb7ALk/UACzisNX9ABtWCcnbQWCZ8cGbTA9EIqPydVyS
   giXozL5HCF4LWeMNOtVgXKUtF2iQcMgiCVmbx3+gTjzFvYvUA7wKbnj6Q
   kE/TVe4e2Bl3LspKHd4mSPDQl9EEj3dtzdiXTsnWao8h0VJo0XQdaTAuQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379690024"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="379690024"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992880915"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="992880915"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 14:25:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 14:25:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 14:25:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 14:25:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 14:25:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO016UsPzR+HyX8Dvziw5JRdyxgOw5a/pCCg9M7wL+cft2O5t8bbXO3rSMfWyxHl200zeNjqOmmk+RNWFwz57pOCQNptyrSs6cpCioK+ysWkTjfHQhebvCL6mafHkCRVkboNhrmZIQxgJdNCuNNlwf3YF2uJxCC6DaBqrgk9QEEF3CFqR4EFqk+GtR7UqXQ4eGXK8HaI+KVtrrttxo3c5jRr+9Nkx1xURl5RZw5gMsbodZsTR8YnYitgAmQCbzlgaEOort3+YxHtG5+xVYpoPrHQOw7pqRlBas6tM3Rv32YdMnHn/dWW7cPLjEPgC0cTV1KVSeF7uNsg/L5PDAIxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4fppr4bNkJ6yoSxMtclZA3VX7aDQHWSGNGzVeO7Cw4=;
 b=Rg1RviFF11+jPLh5zyoeu4zpJf/gXubj+cMPQLSTeM/Ufh8Xvzbc/BB3e3tdsEKuasYaJLxUqPUzyKUccLgDgOQx3lo8Am+4VtXRcsGYibiWji0CDtRHE1vgIz5vZKuQoDOPc5DMLlRGo8RcW3KC7zqlur2AAqIB41pkzV74EMBGjnBX/DswsesfLBPqzE8qebrzT8m+CjoRKT+wWQ0DL4hzPYy31ht/HlTz6PzfKi+mFAQ5UNJla5ZcB8qw3QoE0y2CX/ksI5+jJhxzviY7apSP0jAQDb+xv6oNfBvgIbxZFS+ffxtta5YWkVCaTW5AYrFkSGQEPNyHIS8HLdO3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.22; Mon, 18 Sep
 2023 21:25:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 21:25:42 +0000
Date:   Mon, 18 Sep 2023 14:25:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
        <jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] cxl: Move opcode reporting from dev_dbg() to
 traceevent
Message-ID: <6508c05367180_3947ba29455@iweiny-mobl.notmuch>
References: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
 <169480883568.2690926.2900058137618374817.stgit@djiang5-mobl3>
 <ZQiAD7AyXZJ9eMEY@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQiAD7AyXZJ9eMEY@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: d13b1d0d-2040-49c6-68d8-08dbb88dd026
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARCjhR787D2hS5NJ4g8ZS/BPAV9zMFZBsDEmsxbNFohEQHwUPGEzgIxTBX+UfLX7W3iwx0i8VHBnGwEMxdM8Gv9UAfGloVeQhQ3ycmLceaqALORFn26Ckz+nd0oNJesT47OLkO58SrxBRMfyiTRkVJaVtNDWS1h2jXhaRwLA5kZtyJ4adavJCy0WzWep+TtzWd5xxgitIU9Jq93z30kFdkA8AjDYZZNI6JtfMnyIRZESKVedwWSxDK/gDFGaOxh+3wZutuRjQ5EZ0x0qyJuizeYJdjP43gFVeEmadzsq0NXc4jDAudLPYhIbdkkCsDih/EWbARK8aj+J3VkUBinSNRPueMK/aamK4aUMh44GYdrGnslhvCqZaQC5KfjnQvB5OfrRI+kNpMluRbz9gNNpUYHuXAkBUJfF8DzlUMOJXieILdGLxU2rXuRC+6JXZR8lCd5ZYy71Uot7lbnYjZqPCTtaQCTM0GWFpJVbnGKrdTTG9SRLjCr4Rvapkxq1yTN/EbrnXb3Yjpli+M/omZ6cfwaY0maKgD7WmPrmKAhRVZaA2G7zlHZlkfTb+ojNuUNX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(1800799009)(451199024)(186009)(38100700002)(82960400001)(86362001)(478600001)(66946007)(66556008)(66476007)(6636002)(110136005)(2906002)(9686003)(6512007)(6666004)(6506007)(6486002)(8676002)(8936002)(44832011)(4326008)(5660300002)(41300700001)(316002)(107886003)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CpzqunjuGLZSGJtDOiwRCwvm69gBUhJJ5lQeEPlyv4iCUPbwpl5wpythj6HY?=
 =?us-ascii?Q?Yu33ydWidkRJXTaxTe/tmkZFyIzJGw386OyJAi5+maE2s957BlMeUyScjaWs?=
 =?us-ascii?Q?FCFSIGuCFx2ESSVH930CyDs+cov5DWgtXAdkHImbzJabzOYESW0ozujc/Vq0?=
 =?us-ascii?Q?25Lptg3QQ8WJZxcsIHrXjG3/tQMkUe1eXK1e0B9kuRcVHMJydDUWu+Le3q12?=
 =?us-ascii?Q?w3+9SeJ2lxPa10njwUThFqDidUL6m7pAgEaBh31CkJOwkrxVEff/Pxj7EWB4?=
 =?us-ascii?Q?Y4w2WkLczoXPyTnpBo6xOKc4xLZU5GS1AXq+EG9sBnvw71rCw7Dczy7PLgeM?=
 =?us-ascii?Q?WqlYN2bWgAIZ5Rgs4Mdl87d5pQKGZCY1jLu1FDOR3FoYftLeGlYEkkv5Vd0I?=
 =?us-ascii?Q?WwqzMp143J1P+WxSydCh+SaW1FiTzDByBluw4Jy0E8IyRquh7uIs+WsqGxeH?=
 =?us-ascii?Q?0/e5f5UffCwIo4CD3rznYRexkm0e6fQCeoZTQrjvOPGpCDwbwNR1LlBBReTM?=
 =?us-ascii?Q?5dwqKsNVH3SXPF+gskNckQEasyN6mAvUPrZL3d/Imh5/vVVRpe2W+059+dOC?=
 =?us-ascii?Q?BvyJ/u0GLSRCd4s54cMV38jHBg+fEZOwwCQ8NPbmKQxiLstau8B8lErwtOQ/?=
 =?us-ascii?Q?p01yT7xJiSpInV96IqxEkcjatsRZWYnhfkPN/QXuuYp9VR7Q4zgp3UHt/YKs?=
 =?us-ascii?Q?/p4a8xMobOUJEJMPxfL/V297wykWKVxbawMQhnupJv4XH9/GwkXUZT2zua/S?=
 =?us-ascii?Q?3J741mbnBlt8smPGGKux8mflOzkIJ0UqxiWT4oMXKDTHxULw5oA406WZ+A2y?=
 =?us-ascii?Q?/F2l2ifJIzjgTNi69hdV+rq/RIOBUQXw46dbP9vVzuD7Y6snOo8xIm/zPMCu?=
 =?us-ascii?Q?mYm5lKGCkF+Mgp6u0rKmApe3CwjbBKEvwzHxYnc3CL9XeB5GuxL32TIy1lhO?=
 =?us-ascii?Q?17ydzxaI8fafpCpnF2ppRj13lNanTGbSsLkSXrvLj7aU4L3VkbZh6bvwFwFD?=
 =?us-ascii?Q?KNS16sU6jcbX1BvhO4FOe8QAookqSjJLzLTkKkc675/xVglm+12MFesWBMOR?=
 =?us-ascii?Q?sVuAEdhQLNeJBpSY/a5TP0MhxQ1h0tBsGcdZ5ZEtr3ZwyJrv5I+933V/lOU7?=
 =?us-ascii?Q?rPA/GogROfTImrfXGaEzct2cXATkygQgzegrykoS5GQNdg8KTrs2z4OiGSfk?=
 =?us-ascii?Q?+3k/GK+CHwJxV0ETfnXHXUE1nytNY2W90Sic00Jd0nkR8RXLTkG2n9CkbcEi?=
 =?us-ascii?Q?AqNQ8YRInzoEO5/wOhvwzx2YpBwc3Nrn/nVwM2ZtJtd1995WxYohdh0G//2L?=
 =?us-ascii?Q?J6aFd0XOgdqU+CWc7eOAtHP7kxUmwkOdlIeqSmhKkt9iaka1pCTvF0iaNdUZ?=
 =?us-ascii?Q?APC2q90kDUAhrRoBqLRShKM8dElYztiyGypq0H/qsBkj24L830I3b/MpMNnO?=
 =?us-ascii?Q?SrIaV3cth0puhFJOoT0VwQEzvbbkW3IDDoCEtpmTqpvXq3YiP27DGCOqx1Nz?=
 =?us-ascii?Q?5PLmaH8y1fYuvjb+pFPSCfIa/JxHF8+mAp1ceAZhJcXUa9KiwA3vPOezLb52?=
 =?us-ascii?Q?ul1xIrF3vAPrP7/zNrJIyJ520peVYQZS6hUSEKAP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d13b1d0d-2040-49c6-68d8-08dbb88dd026
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 21:25:42.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXDUS9cqgtgCbLID33tybcko5ccMUn9ZxScCL0JPZiC1I0O1fNKFcTYUgRIiYZp3vJzmC0y88u1c50qmzHhRGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Fri, Sep 15, 2023 at 01:13:55PM -0700, Dave Jiang wrote:
> > Alison has reported that against certain hardware devices the opcode
> > discovery dev_dbg() can emit several hundred "unsupported by driver"
> > messages while parsing the CEL. Move the emission to traceevent to reduce
> > dmesg spamming and let software parse the output if there are interested
> > parties.
> 
> Thanks for reducing the spew Dave.
> 
> Considering that tracing may or may not be 'on' can we just not
> spew anything at this point - no dev_dbg(), no trace. Let the user
> ask for the opcode list at their leisure, at which time we'd dump
> it to trace log.
> 
> Is there a mechanism in place for user to ask for logs?
> (cxl list -m mem1 'show me my opcodes')
> Barring that, I'm assuming users can do a pass thru of this cmd
> and get whatever they want.
> 
> Counterpoint - is there a subset of opcodes that we'd really like
> to dev_dbg() about at this point in time?  ie missing opcodes that
> are going to make the device useless.

IMO any command which fails and is fatal to the device coming up should
trigger a dev_err() somewhere.

I don't think that is a guarantee currently though.  Even something which
we expect but does not fail the device is IMO a candidate for dev_err()
because it is unexpected behavior.

Does anyone oppose removing the dev_dbg()'s in this series?  Is anyone
looking at the list of opcodes this way?

Ira
