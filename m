Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2FC54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 22:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjA3WYI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjA3WYH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 17:24:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7274C1DBA4
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675117435; x=1706653435;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RFkDFpjLl4HkX85uCV7F2mhlF/kkK2r2p/HRATqjEMg=;
  b=FAvFzJbxkhygL9/Q0QHYDI6ixWx8ihTk1ZCllrVt5UiaKCvKaco1zvLo
   Ca1Vf13L/kDjZSro6L1FwAQ1gXlk3KhpwATuTzSCtC5PUfMOY+EOZifr2
   WpB9ZOPKXbCG6y/6fOn0LSSkphxec+Nxx9E8ZoSm+cMYKDdDT5p/86b8w
   /HpcB7jMJErJUCgjr5wsQQ0adU+44FhrAxwtDSaPQf4J2x4kBCopXBBjT
   qAGwHT2tBzdqQp3liQeg1HJYseV55OMgMqhDEo+0vhhbgadEzHM6p4AR9
   eyXNNYdNCvO7LDAHqoSdyOtJcdo3dWmmSCkCpLOcYAMceEQDI8erZqVeO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311312072"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="311312072"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 14:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909672054"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="909672054"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jan 2023 14:23:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 14:23:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 14:23:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 14:23:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ/fQx7okZcs1M1tUyurX/N3pmPpS5FAe5flnc3hCer50gh9eQN4nP9Y1al/hb3GaMdgWGnD8UqMmKrlrUMeKHEeItbF/+Du8CvBHIygSH4i5/gTncic/ZV8tFmYfdyE8JrCSwhG14QX/Up82DcVGUrsj+2BkpVtMmnXEGdqUwt2jxdTDb9i/Z9k6+Wczw7VdiVB8L1YRWUelngEjNtco7wKePVgd3gsvKHpMaqdQ7zdK7FRVHR3XHaE/xZgGIU9mG7Oo0Kv+1bfps9jJTo5Vy0GLFU7mvqxW/TmrhCO2NtWUlxf8UtXxUWYgdfECSAEeU6LPy0gK6/Suw2jU2923g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL6uw31dN7KEjaEhRwplnLYAs9fpWsfr2ffwomjCBHo=;
 b=KlUoKOPm53vKR8AhSdG9/GhMwsVKYfTy0LVMzJQqXbYkphkK1QgFNfvW1p/5HOfzaMGGroRsj+NMS82aNfKGnh9XpKEUe6q1A4blZRyqkpevBK7a5BKoDuYlZM7UGcDNuJ4B/57PgknpTqcGjxjzQohF+A0UtnjaWFS3j9VPbouBC3s4s9/PqVpW5//a83fmJ8WEd15F35ZH9y03OZ2/lrSqBI0T5gY7vPpWUAXglhMy5qjSOXFU3C2dqRfcoI77RGlSTTywVVSDY79rv3t7oAx780alZG57yJ6ll9teUldJ7zHnrToOW0UhhEruUtwKRku5opRtgag7CQ34J4YGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Mon, 30 Jan
 2023 22:23:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 22:23:50 +0000
Date:   Mon, 30 Jan 2023 14:23:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <63d843729334b_a2cd4294c2@iweiny-mobl.notmuch>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
 <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 068b8a93-9167-4c73-7d3e-08db0310a988
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWWt2jnth96986koaDpfb36qsQHZAiqjnSgdZTsi+7l59RbQG0N09LUjQ9/Cu78LMjJAobFf6MLR4sbbhXds6QwWkbFlLgbJIrjpIAYH8FjiO16vBfGcINitzhdz8oVdBHlCn67s/wQytrxlAMit8MfIKZaj9IdthMPdkG2OuQP6bwz1I7L6CX5tacSGeaSTwgmtvK33Xhgt2Cs6f1lwkT438gyLcWfQFKZUtVQIo5yUz6ZW5Rq1jH213Yx9lNq5vb3te/wQqVXbav6J5f2KqnHKWJ7lAs61I3Pg9yp90WWx6OenKj0h/NArTdyoeDuWT4/I/k4niKIQcBmjqKf2Tw1HEZ0B6U1Wkg0rB1RJv6dT8pEQkU6gSMRrz+ln7CugDnZefTqVjx3kfVIxcYcUBNVFxS3EfPJiwRfqAAylAc5tjMWxYAhZFfoJjw1WcRz8mRFaPmS/SjizZUSRo2jgKh6NY9BE6/i7Vs9malgRG40XkO6wRJWBPjQcqF3HlUCsmQJcGktZp6yXbtkd6ig+TL706Tf5x7oDJ+YRKu8E+mwI0hJ7RHUPi5/6acMLG4iUf3XaBoXmaayKQ1pUHg0ax5HYr3lACOoz9Deznn5W+SeuQk9jAqMjOq9uLnq+Ov0l6gPV6nOtxJ74R4i1HhpdnmYsrb1g/kzyQF5jc50vSNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(2906002)(44832011)(5660300002)(82960400001)(8936002)(38100700002)(41300700001)(107886003)(6666004)(83380400001)(86362001)(966005)(478600001)(6486002)(110136005)(54906003)(316002)(66476007)(66946007)(4326008)(8676002)(9686003)(6512007)(26005)(6506007)(186003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CFZH6uZ4NFZj1StIk8aSDS6wxBKnvClNcdhyY+jHZ/M1L0jKGGf7kleiplP?=
 =?us-ascii?Q?Zh4kQFU+rF/qBs1OcvNpcSXA4mX301ogeqfuW4ZZZlKpjS2It1TeOVzxYc+Y?=
 =?us-ascii?Q?S4HIfBHOdTu6sR+GAAFqiPjvpg31iTf2cgAh7brZrAhaMwQfx/ID2EMRhW8h?=
 =?us-ascii?Q?R6BKaKVrpDhpZFo8nHo1DB5c/ZGBxx6qJGBYd6gMlu5UdwOMC/JWjm83gmhC?=
 =?us-ascii?Q?UKL58GwVwPr552vJw4mzAlutfaitGJyqGLVR7+4lV+YqVfX5jzstsTB64rQX?=
 =?us-ascii?Q?YCwD6oJyYwQ9TI7DLFB0B3O6RYKFeqcgTemcLApmAG3G30gUZRdA4O0cYZMG?=
 =?us-ascii?Q?tzv/1KOwHQJa3V6wt2cH1mYLkokiiIHDYouSJOCJfL0KHzpzY366M36y2h7O?=
 =?us-ascii?Q?6UDxOXOp/JbfiAcETwyIG+zKf+1SkKiB5SJJiGE11eP3NvBMKhvo51qx3h/U?=
 =?us-ascii?Q?lopqQJGi8XJjQK4IdQnVJ/YHpe1DqRsg/evm6gdAm7N3BeGzuVZtZ/dE/uVa?=
 =?us-ascii?Q?fURraS/1E8MPPk50v2ntsGxkI+LIQGjnoH0Bq3jr/X3VTopCmSgLoWPVA3lt?=
 =?us-ascii?Q?DMn6MHJYVxatzh7mjtJDHTYxnU8gRIxCsZ2fw7Y0wsn6erQlozRU1kvidSjc?=
 =?us-ascii?Q?X9fC0e5mKM+g8wCqOsDQO0OBsvC2o3ah6rj5fCXCk5v/1cfllsV6uufc57dC?=
 =?us-ascii?Q?cE7puiTS1XfnrYlygVDnjnagCod+s+kL/+uJOoA1WgJaKVxqME9SDOWGKdAG?=
 =?us-ascii?Q?2mFg44wsqdcTKnAEE5HhHlC6rEvQ8GK3JdJwJA800pImZRxbRanEv/WFVVOd?=
 =?us-ascii?Q?EsO7XWEGGlh2KYoXaksxBa6iakEcTqd/GYlDUU8/eDstGVF60Q8D1NTHTEFO?=
 =?us-ascii?Q?13kmIcEO2HA1aTkSt1Q4fR6onUVONm387VpP9/fpZTUsz3QkoCg5Sulli/QP?=
 =?us-ascii?Q?mz8EOWn3VjDA/h5AWbU1YfuG428nlr7X1p/I3s1osTJaYGs2og1bU6LGQXgY?=
 =?us-ascii?Q?ambJkuWEvCn/NLmtgJM55e+mo2eAEQ54cxfyAT1RkxyXPW9hV86MwzMXlmno?=
 =?us-ascii?Q?e9+A4icXbyJBjM9blpRhF2mQWWzKwyQtZduY1g/86TAXN5SNCO0CnJcS3tSG?=
 =?us-ascii?Q?fNuZpl3bfbI5mF4Sz6PvxlzxptYD14hrS7QNY7FqYQzqm80Bw3nh8gK3Nv6L?=
 =?us-ascii?Q?1dqAn2Dd1SDEF9akbtKfNMjFYkk4pq7YTxvQp1Yd91acSdIQq0p8I6u2ZXDg?=
 =?us-ascii?Q?ImNRbcpg7QOeOC9CeDoZQUGgdhZXgtvymUOH8JEbZl2RDdiJTVWU8SP4dZH1?=
 =?us-ascii?Q?epBg0TSGA2FtqUrRRFO7YOPk8yIjHWsiS4JO+2ohS8rQogDJepTVaxMbj+dk?=
 =?us-ascii?Q?8YWa5B7C5ZHyYKoGFFgzAoMrz8tw7/AHzo38fc/1uNj57WR1yMfbMObac8hu?=
 =?us-ascii?Q?IbpQ8MFtRpVMFJsWkzOkYaJRMqA3hA/ExaYsGtoChAoiyY1J7vCYQe4kxMSR?=
 =?us-ascii?Q?B1GpeHVFQwWjXZ8ttwwlWFnSujiRnylbyWCi5/PRUrmRl3NIDV71QQccPG61?=
 =?us-ascii?Q?6MZEc8hweEhLMbjrd1MrdVIh3tqvYlam9Dg731Eu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 068b8a93-9167-4c73-7d3e-08db0310a988
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:23:50.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dXdptkC7z44nDRtGkQ8s4FkS/MxtfFNKwWdrUXxEm4cHzAT0cJux1hIIHDGI91gMsSCXonDOue7mYd5KOvxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> > It was pointed out that commands not supported by the device or excluded
> > by the kernel were being returned in cxl_query_cmd().[1]
> > 
> > While libcxl correctly handles failing commands, it is more efficient to
> > not issue an invalid command in the first place.
> > 
> > Exclude both kernel exclusive and disabled commands from the list of
> > commands returned by cxl_query_cmd().
> > 
> > [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes for v2:
> > 	New patch
> > ---
> >  drivers/cxl/core/mbox.c | 35 ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index b03fba212799..a1618b7f01e5 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -326,12 +326,27 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
> >  	return 0;
> >  }
> >  
> > +/* Return 0 if the cmd id is available for userspace */
> > +static int cxl_cmd_id_user(__u32 id, struct cxl_dev_state *cxlds)
> > +{
> > +	/* Check that the command is enabled for hardware */
> > +	if (!test_bit(id, cxlds->enabled_cmds))
> > +		return -ENOTTY;
> > +
> > +	/* Check that the command is not claimed for exclusive kernel use */
> > +	if (test_bit(id, cxlds->exclusive_cmds))
> > +		return -EBUSY;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> >  			  const struct cxl_send_command *send_cmd,
> >  			  struct cxl_dev_state *cxlds)
> >  {
> >  	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
> >  	const struct cxl_command_info *info = &c->info;
> > +	int rc;
> >  
> >  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> >  		return -EINVAL;
> > @@ -342,13 +357,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> >  	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> >  		return -EINVAL;
> >  
> > -	/* Check that the command is enabled for hardware */
> > -	if (!test_bit(info->id, cxlds->enabled_cmds))
> > -		return -ENOTTY;
> > -
> > -	/* Check that the command is not claimed for exclusive kernel use */
> > -	if (test_bit(info->id, cxlds->exclusive_cmds))
> > -		return -EBUSY;
> > +	rc = cxl_cmd_id_user(info->id, cxlds);
> > +	if (rc)
> > +		return rc;
> >  
> >  	/* Check the input buffer is the expected size */
> >  	if ((info->size_in != CXL_VARIABLE_PAYLOAD) &&
> > @@ -446,9 +457,15 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
> >  	 */
> >  	cxl_for_each_cmd(cmd) {
> >  		const struct cxl_command_info *info = &cmd->info;
> > +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +		int rc;
> >  
> > -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > -			return -EFAULT;
> > +		rc = cxl_cmd_id_user(info->id, cxlds);
> > +		if (!rc) {
> > +			if (copy_to_user(&q->commands[j++], info,
> > +					 sizeof(*info)))
> > +				return -EFAULT;
> > +		}
> 
> I like where this is going, but I think it is still useful to return all
> the commands even if they are not enabled or currently exclusive,
> especially since that expectation has already shipped.

I recognize that there may be an expectation of functionality but
userspace can't _do_ anything with the disabled/exclusive commands.  So
why not actually fix cxl_query_cmd()?  Effectively keeping the current
behavior will neither fix nor break existing user space.  But more
importantly the patch I've proposed makes existing user space more
efficient without breaking it either.

This is because returning these command only allows libcxl to issue those
commands which then fail.

The way I see it, there is no value in returning those commands at all.
Unless we want to have user space provide additional debugging for the
reason for the commands failing.

> 
> I also think it is a bug that this command passes kernel internal flags
> like CXL_CMD_FLAG_FORCE_ENABLE.

AFAICS It does not return that flag.  CXL_CMD_FLAG_FORCE_ENABLE is a flag
in struct cxl_mem_command while struct cxl_command_info has separate
flags.

AFAICS only struct cxl_command_info is exposed to userspace.

> So let's declare new flags in
> include/uapi/linux/cxl_mem.h starting at BIT(1) and do something like:
> 
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..1ba0e12fd410 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -87,8 +87,10 @@ struct cxl_command_info {
>         __u32 id;
>  
>         __u32 flags;
> -#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
> -
> +#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(2, 1)
> +#define CXL_MEM_COMMAND_FLAG_RESERVED BIT(0)
> +#define CXL_MEM_COMMAND_FLAG_ENABLED BIT(1)
> +#define CXL_MEM_COMMAND_FLAG_EXCLUSIVE BIT(2)
>         __u32 size_in;
>         __u32 size_out;
>  };
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 6ed8e3654939..24469668f1af 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -427,6 +427,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>  int cxl_query_cmd(struct cxl_memdev *cxlmd,
>                   struct cxl_mem_query_commands __user *q)
>  {
> +       struct cxl_dev_state *cxlds = cxlmd->cxlds;
>         struct device *dev = &cxlmd->dev;
>         struct cxl_mem_command *cmd;
>         u32 n_commands;
> @@ -446,9 +447,18 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>          * structures.
>          */
>         cxl_for_each_cmd(cmd) {
> -               const struct cxl_command_info *info = &cmd->info;
> +               struct cxl_command_info info = cmd->info;
> +
> +               /* wipe kernel internal flags */
> +               info.flags = 0;

Unless I'm missing something this is not needed.

>  
> -               if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> +               /* reflect exclusive and enabled */
> +               if (test_bit(info.id, cxlds->enabled_cmds))
> +                       info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
> +               if (test_bit(info.id, cxlds->exclusive_cmds))
> +                       info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;

Ok Just to make sure I'm following you.  This is then expecting user space
to check these flags to know if this command is available or not?

This means additional user space changes to use these.  Which is ok.  But
what is the value?  Current user space will still be broken and future
user space will be more complicated.

Right now libcxl issues a query before each command to ensure the command
is available.  These flags can't be cached.

The patch as I have proposed simply short circuits the already failing
path in libcxl with minimal changes.

Do we have a use case for user space to report the current disabled and
exclusive commands?

Ira
