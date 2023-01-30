Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E3DC54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 23:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjA3Xxe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjA3Xx1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 18:53:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AE18B3B
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675122790; x=1706658790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yCF31VOQa6bJs7gwwrvL/e010bQERHY/AmeWpKJ34WU=;
  b=A5lLptAaTRH1sLj+Qbpv+CcPS0CQ3Q27kGnhlTAEQtE3WQqXnOQgz5Tb
   Uu6sh1r1h14/Bwktwa4RqV7z6d1uvp0t3jIw/v9Kv4i2EM28bAMLJlfyj
   tHmJQPePiv2QRl2LmaORE1jQPht9UF6s8S1ZIi/OHdjwwsJzXPuq91mwk
   yF663FxyX91hPweOOOLzdoSA1rcBLOjC2AgFg3xKvJrFpy7E6Mpw3L64v
   Hm7T062IbQmG/kPPAzDWbBxS3XfvnKRI52Eh8m83h/gnAmWuupgw7j/hF
   Wcwp3Cog48wLunM1VPBUDydI9hZqhPYHfN5t8oO1ZfIfYb4UQqXIsKsLc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325403989"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="325403989"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 15:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772729459"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="772729459"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2023 15:53:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 15:53:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 15:53:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 15:53:02 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 15:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT7btWzOL64QsHI3CUW8G97wIJA9ddlmdJFm7O/gC3B1AAET4jqlNSbAvTyhWtPUWLAlZYhfGMmS/spDdKfAQPXqJRGyiFRL6Msub6fIMVBtrG65Rx3MQLcgx86aWYN1L/wt57+Foxs5ERISE+I9NP0Mwp/NTZJOusZY9v4nJg1o3ipqFk7lPYTg2OezEQMqYWTPYuQlAgrW/XF+4XGWJZaWi1GPV/gVW/QjL9V9SBpTl2JfcCeG4XXedk6Y/8q73Fkgz/vYr5caCzVYwuJyjeC4g2tXfyD3xv4QWASJiP0UdMQ0++pjI0WtQzPFYbHCTX7IU4HLtaC39Mzn/Jx7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ycPfbHmS/Lz8nX1ZH0Ij9pBsJoYmnf4XebiOW6XO00=;
 b=cdF1vdAMN7lPszsPZNKZ2aPVF4cz+LmtUQllpLtr6swBV0oj07rMVr+NsgE7KXzElZ8UWK9495XaqBG+eD93kA4CXALpjHAeeIDbBgNnmTs0SM6RnstrgAWFrE7MdDaw8sVVqpuzM8SlZ+AujEWC7Zv5ipp6JWrCw6eTQn69FQZKBDkKd/s+BYmIPrgh9jV1EfwJz0B/mlnWBSP52kusAEH/BFGINxEuxiyPB5/oVuNA51w79WQhlQtf/KL6RIY6KW8zXyu9MLwL7Zwy4lkK2HSvuGqlQK6TRUBKPWqBDHgr1P8ScmkwuAQYlendHLpgRCdgDR5OZakWeIWa+zgxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20)
 by CH0PR11MB5491.namprd11.prod.outlook.com (2603:10b6:610:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 23:52:58 +0000
Received: from BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::a926:e4e5:d28a:f219]) by BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::a926:e4e5:d28a:f219%9]) with mapi id 15.20.6043.030; Mon, 30 Jan 2023
 23:52:58 +0000
Date:   Mon, 30 Jan 2023 15:52:55 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, "Ira Weiny" <ira.weiny@intel.com>
Subject: RE: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <63d85857b1648_8e2c29465@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
 <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
 <63d843729334b_a2cd4294c2@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d843729334b_a2cd4294c2@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:a03:114::22) To BY1PR11MB8127.namprd11.prod.outlook.com
 (2603:10b6:a03:531::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8127:EE_|CH0PR11MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eef3e94-d289-4cbd-7ebe-08db031d1d14
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vz6B90Djy8o7zaVjOkZcvnsLtYyUxx6qhlCawO+eWWX78uEvfKmoA84tKY9YgRAMrz8/I4q2zLBfRa690BKv9WtJL+uGMyctBU34CVF0BS/kucG3IpoU/vJqHgynFou4G/cVnvMYR6l1BI9Znh8EEoCwmkSmgerSjE8vUydVntjeqfunupGoKYZwo5wTBaQZMJ9YJfSwfI9umw4om9OoxkQNmr5VNXo2/kZdXce+UnINSstrkSz/Zi37zib/QiN4Hn0gPqIVivfPrvvk3ZEHl/ZDuj9ungCBaJWvElAic6MZge6VE2JFEGA4aGwR1mz84Uznpd06n5kInPSf1D8/lzjUTVoiJHNvlNtlRaw7j5PPIDSoQocRBMxlh5mb96G/FjtZvIrGJaO8UGuFoYlQHXkFGQGWajEEEJ9v1YGJt00wqezDpjTVdBNdoCnql34VCZPyQ3TX+iZQNJihKeWKzdDMB2G5u3hNAjOBWBJ4p6wah9OSbsz2NyRC6x7dVWz3R3bwOdIB5V5cufrnSMJy5fY1ZHWYm9Tnafctio+4YJhbKGJbrZboasucDN4i8MKsnHp04lJcIHi75/F96ZllhRMfH0s4/p/kFvjoomNirgCix0wISVqP/Qd2CVvwYGvcL5sj3JPEQxRxoy3jbgUMIrnoJ1AryVqKwl/2Ij9Cm/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR11MB8127.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199018)(8936002)(66476007)(66556008)(66946007)(316002)(8676002)(4326008)(5660300002)(54906003)(110136005)(6506007)(2906002)(41300700001)(6486002)(966005)(478600001)(6666004)(107886003)(26005)(186003)(9686003)(6512007)(83380400001)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3VqsG+pgUMVwEOeHcZ4nEDMcKKWlAMPiQayu7uQXXIBJkb7+EPlo5iqsmBu5?=
 =?us-ascii?Q?ur1SVo4QSM+OeYu2g/zgwjzPprM4uJz6glds7aOTP2ig/3LZ61t6gcE9sDG6?=
 =?us-ascii?Q?QQB3o1KAW9UzBuzda3WgkGf3a/J+mJM3We+4bxJDfK1Ft1z3SIf/sxZEl+9Z?=
 =?us-ascii?Q?woS3I+q0AOY21kU36JeF/a8SFT9lW4YCHFS3ZTiLA4DYFv60qP3VAdBpJrrW?=
 =?us-ascii?Q?pCYUVUcqvfwZVmL0d/vUU6O2tHul5btEmz0G5f0j3oxLhPGNitilor3oDk5a?=
 =?us-ascii?Q?8kylSNKwCkSafQ4OD5rRfw086bTlj1XbVp1HS6+vbQ9W/mzXigD0y/wERFXE?=
 =?us-ascii?Q?1G4XCKoH9XyE6ovys0n505YcyjxlgeLW/M2fLui91kB3DqaMXYP3FybwzMx/?=
 =?us-ascii?Q?xqbwsxIV7bqQsmyeXk56QetxcM3GBTyUxBtflrLYiPGDRTuc+MLiyebaa+A3?=
 =?us-ascii?Q?vuPhqKNfwLSUbts0jBCBrGVwvtns1kWseGJ8UGP6OMPtSrxFXyo4F4UEfw7J?=
 =?us-ascii?Q?FjXyMBJLA4dEUsJ586UuJsVMq/DRaCeScb9Qih/RfPzFhYYgtb8SI1sEl67B?=
 =?us-ascii?Q?xFTcaDFnPM5p6d9VhLOyTf7QZyuzwbaZ/+xHMMs6etlVOYsgI/I+wNYv/qu6?=
 =?us-ascii?Q?NvBF82HJsa6XIGNfRKPE3IG8293B6DeXcYZhyby03ucYFAqEV7g46xJhENGf?=
 =?us-ascii?Q?sV8pt0XCPBRX/ll1QN19ybBDA/RJFGrLZYc74pqLCaM5OATgzKnDRLcRCO/z?=
 =?us-ascii?Q?8KA8V3as0fhiQ2UjxqMOEfBGfL55ACeAOC1LBnTR5t+LOXlYPA/sKT8mygUj?=
 =?us-ascii?Q?g+5phXzVn5/F+1RibWaxcta5cxjjbjGCpAZkmuFLKstoySAcRtRV1kk0gZv2?=
 =?us-ascii?Q?7Ishe/F/2ZEBnMRbnk9uen6H4zX/DRKSZ1SY4Mfx5OlO4xGftKKHMrLbt4JY?=
 =?us-ascii?Q?WxU79mgrKMkypmXlggXCa7W0/2G+uCvfHzO48y3pD/uAxm+3tQnXc1urKc3u?=
 =?us-ascii?Q?IdxDUzRqhO7stSUektghe+lOEF8012n/sLvlT9hRJNgXDo2LgdB6C+i+S3kw?=
 =?us-ascii?Q?Qu9t9cZWc5mjgS09AvyC/DQ548HzXZCxg7AUh4k/kZvTOyF1v8HNxJ+YgkH6?=
 =?us-ascii?Q?o2zLSBy0h+lkS2Yj1LMPNUsHaursNQU4JVmh+UdLznYhZSDLD9+kYzNYfuPZ?=
 =?us-ascii?Q?yWE5T9V+PtHX4ufl8JYU90jb9qo1VrgLgI4S7hk3YHhhwPg81L7kBItFNoej?=
 =?us-ascii?Q?AgwO2NYrVKewfW1ftmF5QzK5nYOOS0uguayQDqAK8C3vFslPxPV4cEqOUdgp?=
 =?us-ascii?Q?SVmXwvXtFoSxipAHVe4t/Lj67PAmOvxlSGUXlr/CS6hUGPJ9a8HZiwfNqV/f?=
 =?us-ascii?Q?EeNK0fVsJNse+QM4Hjr+m1X+J/GS05iUkVUiLoJFCLyb22t2k0MqiufRPpCv?=
 =?us-ascii?Q?zFhmd7sof9x665+VtCDtBDHH/Rl9/RQc5vpuHbUNuKuobyJh2pbLSz4LjlFL?=
 =?us-ascii?Q?dUgHVdeLJqhuoNF06kyhZ1p8JfW0DARXrI+KjGSIcDHjc9PDWrPMUp4gx/kV?=
 =?us-ascii?Q?bySEj0yLnQMhHQIlw7fYLiaqXFCFbKwhloYBi4Tqui8GQ/qw3EwxDX/QBYgU?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef3e94-d289-4cbd-7ebe-08db031d1d14
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8127.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 23:52:58.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eigdzypoUD+G3NzJn+ty5AbbXKnviO/C1yucmn4GNru78CwFhQUM8RMM88MgPEJ3RNJx1nZKuiqap/9iWJPcNsJosDkik3zCggRvyh/NUPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5491
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> > > It was pointed out that commands not supported by the device or excluded
> > > by the kernel were being returned in cxl_query_cmd().[1]
> > > 
> > > While libcxl correctly handles failing commands, it is more efficient to
> > > not issue an invalid command in the first place.
> > > 
> > > Exclude both kernel exclusive and disabled commands from the list of
> > > commands returned by cxl_query_cmd().
> > > 
> > > [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes for v2:
> > > 	New patch
> > > ---
> > >  drivers/cxl/core/mbox.c | 35 ++++++++++++++++++++++++++---------
> > >  1 file changed, 26 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index b03fba212799..a1618b7f01e5 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -326,12 +326,27 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
> > >  	return 0;
> > >  }
> > >  
> > > +/* Return 0 if the cmd id is available for userspace */
> > > +static int cxl_cmd_id_user(__u32 id, struct cxl_dev_state *cxlds)
> > > +{
> > > +	/* Check that the command is enabled for hardware */
> > > +	if (!test_bit(id, cxlds->enabled_cmds))
> > > +		return -ENOTTY;
> > > +
> > > +	/* Check that the command is not claimed for exclusive kernel use */
> > > +	if (test_bit(id, cxlds->exclusive_cmds))
> > > +		return -EBUSY;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> > >  			  const struct cxl_send_command *send_cmd,
> > >  			  struct cxl_dev_state *cxlds)
> > >  {
> > >  	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
> > >  	const struct cxl_command_info *info = &c->info;
> > > +	int rc;
> > >  
> > >  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> > >  		return -EINVAL;
> > > @@ -342,13 +357,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> > >  	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> > >  		return -EINVAL;
> > >  
> > > -	/* Check that the command is enabled for hardware */
> > > -	if (!test_bit(info->id, cxlds->enabled_cmds))
> > > -		return -ENOTTY;
> > > -
> > > -	/* Check that the command is not claimed for exclusive kernel use */
> > > -	if (test_bit(info->id, cxlds->exclusive_cmds))
> > > -		return -EBUSY;
> > > +	rc = cxl_cmd_id_user(info->id, cxlds);
> > > +	if (rc)
> > > +		return rc;
> > >  
> > >  	/* Check the input buffer is the expected size */
> > >  	if ((info->size_in != CXL_VARIABLE_PAYLOAD) &&
> > > @@ -446,9 +457,15 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
> > >  	 */
> > >  	cxl_for_each_cmd(cmd) {
> > >  		const struct cxl_command_info *info = &cmd->info;
> > > +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > +		int rc;
> > >  
> > > -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > > -			return -EFAULT;
> > > +		rc = cxl_cmd_id_user(info->id, cxlds);
> > > +		if (!rc) {
> > > +			if (copy_to_user(&q->commands[j++], info,
> > > +					 sizeof(*info)))
> > > +				return -EFAULT;
> > > +		}
> > 
> > I like where this is going, but I think it is still useful to return all
> > the commands even if they are not enabled or currently exclusive,
> > especially since that expectation has already shipped.
> 
> I recognize that there may be an expectation of functionality but
> userspace can't _do_ anything with the disabled/exclusive commands.  So
> why not actually fix cxl_query_cmd()?  Effectively keeping the current
> behavior will neither fix nor break existing user space.  But more
> importantly the patch I've proposed makes existing user space more
> efficient without breaking it either.
> 
> This is because returning these command only allows libcxl to issue those
> commands which then fail.
> 
> The way I see it, there is no value in returning those commands at all.
> Unless we want to have user space provide additional debugging for the
> reason for the commands failing.

There is value, similar to the motivation to print the status of enabled
commands. It is useful to know what functionality is limited by the
kernel and what functionality is limited by the device.

> > I also think it is a bug that this command passes kernel internal flags
> > like CXL_CMD_FLAG_FORCE_ENABLE.
> 
> AFAICS It does not return that flag.  CXL_CMD_FLAG_FORCE_ENABLE is a flag
> in struct cxl_mem_command while struct cxl_command_info has separate
> flags.
> 
> AFAICS only struct cxl_command_info is exposed to userspace.

Ah true, CXL_CMD() leaves info.flags unset.


> 
> > So let's declare new flags in
> > include/uapi/linux/cxl_mem.h starting at BIT(1) and do something like:
> > 
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index c71021a2a9ed..1ba0e12fd410 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -87,8 +87,10 @@ struct cxl_command_info {
> >         __u32 id;
> >  
> >         __u32 flags;
> > -#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
> > -
> > +#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(2, 1)
> > +#define CXL_MEM_COMMAND_FLAG_RESERVED BIT(0)
> > +#define CXL_MEM_COMMAND_FLAG_ENABLED BIT(1)
> > +#define CXL_MEM_COMMAND_FLAG_EXCLUSIVE BIT(2)
> >         __u32 size_in;
> >         __u32 size_out;
> >  };
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 6ed8e3654939..24469668f1af 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -427,6 +427,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
> >  int cxl_query_cmd(struct cxl_memdev *cxlmd,
> >                   struct cxl_mem_query_commands __user *q)
> >  {
> > +       struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >         struct device *dev = &cxlmd->dev;
> >         struct cxl_mem_command *cmd;
> >         u32 n_commands;
> > @@ -446,9 +447,18 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
> >          * structures.
> >          */
> >         cxl_for_each_cmd(cmd) {
> > -               const struct cxl_command_info *info = &cmd->info;
> > +               struct cxl_command_info info = cmd->info;
> > +
> > +               /* wipe kernel internal flags */
> > +               info.flags = 0;
> 
> Unless I'm missing something this is not needed.

Yes.

> 
> >  
> > -               if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > +               /* reflect exclusive and enabled */
> > +               if (test_bit(info.id, cxlds->enabled_cmds))
> > +                       info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
> > +               if (test_bit(info.id, cxlds->exclusive_cmds))
> > +                       info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
> 
> Ok Just to make sure I'm following you.  This is then expecting user space
> to check these flags to know if this command is available or not?

No, there is no expectation that userspace check these, especially since
they were not mandated before, but they are optional useful information
for future debug.

> This means additional user space changes to use these.  Which is ok.  But
> what is the value?  Current user space will still be broken and future
> user space will be more complicated.

Value is as above, more user visible debug information which will be
important as different levels of enabling make it out to different
backport kernels.

> Right now libcxl issues a query before each command to ensure the command
> is available.  These flags can't be cached.
> 
> The patch as I have proposed simply short circuits the already failing
> path in libcxl with minimal changes.
> 
> Do we have a use case for user space to report the current disabled and
> exclusive commands?

Nothing beyond future debug flexibility.
