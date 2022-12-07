Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E6CC4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 21:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGVVW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 16:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGVVV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 16:21:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04434E402
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 13:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670448080; x=1701984080;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=APQO2Fdop/8ZN0GeB54BHkPIU/fHHffueTUmhVCOc/0=;
  b=avXFcni2rP6vr+8HD5XK51PNJUp/Y8cmRneit1p/iFlxMWahpcgCHrgJ
   KPL2ZAL8/d2L9MQ6pvoqeK3UsPGdYtM7fkOnTQaWkNNKAMVkdWsodsiyW
   8G+Y/aaosaZljF/Z+oWlRAYim2zf7C0pdoC4xITRchGfTi0Kw6e1E1D25
   7xQn/onI+VEB0lbbz4tBtSWe/XzOl3qoXJKbOzyqUBpCFwCpb3DKgy13D
   udlZNBvdxkk1NNmpwFASeajUbqzLNwjgtZ/Y+W8JFCXNQBjQr9BR/zOfM
   SmooGI/BzhHaX8KKLQnDzp3BNB0Ylj9BOFXym19YCADoXHw9FuOpplJoq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="379175278"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="379175278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="597108632"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="597108632"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2022 13:21:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 13:21:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 13:21:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 13:21:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 13:21:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD0h4bpeHk+24u/NlDXfgglfNfRdD0zlV8IJNlB4tXoB2KEq8m5FY/uIT4++dXEbqb9BTtOh3LuuYxDu2A1m20FpJgvnWWit9hnvI4RJqtmgxRiEUHDn7+Z4fQjKb85d35QpwpTudiheQzflmoVPg8QDaA4dbNRduPJzkUhiorJ36PwNxpRjJStf3c/Rg793yPdN5V4h38Ah8vDRoGkaxgSVxLb5ZvJR9G/W/c1tKQD+iT+njzc+DEeamLsiLJXkFd0oOvzeXMFHncer10BuBy8CLV7JBaYCn05FxoiGbh6dp+nCqHaU9tUKIS6JnFpkvvgKwz/vnd3xJySbM2Y2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eav6W3b0dw+G3E61z6EyaIyEedgaMCzLzB6t8+yf3JI=;
 b=kKr2TsynJTTM9U2cG6Fbdk8aaLrT+J8oDcG1QxJh2v3dgcEgcXy6nwIQf5Ez7pBSSyPCdr7A6uwEflNOIq1Sr8AYBxQlW8xiXwsATX4VSnU44B463KKBh5e+boT8fxzS9S92SGEzk7zy3z9Yt4QwHzyGykHVFfHlcT181qdrhPR7wNYEPgGV+v7nswr+PgZOWWlLJUBNOAc2Xq0FmpNZCV2bcTCPWOjyB1lUvqrTmiWUH/73FBL1T6kUzolW6wd2TAwF66IS5KXmh7F9WQ6d1xVA/8GEFOLx5fPYWvIT7CqjfklWBEmftAbC4kyzqMAbniMslcIF4JTosyrj343VDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB5967.namprd11.prod.outlook.com
 (2603:10b6:8:72::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 21:21:10 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 21:21:10 +0000
Date:   Wed, 7 Dec 2022 13:21:07 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <639103c3b0853_3cbe02944d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
 <20221207161026.c2qpn4p7uplm5qkt@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221207161026.c2qpn4p7uplm5qkt@offworld>
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: b82b6948-69af-4a18-00b6-08dad898f604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ss+5EZr8ZKn+LiEz81FitvcnkwdBucDOsrHph4BMje50LwsiymzEfO4UW69Zhj6FqPYgoYZHX2pvahfVoXn1vOsC6df6UKWBZH6aJis7Q41+vEqiLK5axDC+gws1ZB04ZCySMctQpvpD4V97GvPIORlqpoKjU+sR00Ww8n831eSzdPOdytr7skW4/7rq7JghE/WtEMunKC/5KPd/A/elHfXCPeyj2oucPw32bL74ymprS5UT92AYJmOaSBhAMxGNBp8RnKt2xCMAlb5qr0WVSJLUiY3F3G85iA0IQzblD/FOHIQyq8dl51bD2R9cFpX00rGZ0pYRpnGWyeC/bLP1lPSXbxFKk85qQoZiguXr+km2ivvJnYLhU8c5CrCSigiBheZlowuJ3LZhtjJk/PwchXPk41gbNkwsHCh/vMEka5gkAlb5KoIaHTHg0w2HHE/IepkV1eTnKhWDUFTxURLeH0W37Od6w1hMCdwM5CFOuPEQpkvlgHphTkljd03o7cLdLzj+9+IwexrhFfNFBfADIgLRv8b1FQ0eYMzUM4CybJielO3b9sJ0MUF0KdJ7tJbXGGzZNxvDogzQ3px4D7jlAEf3FO7XRerz907WClnBLLO/gzbmPMq9zrSl2ZaPSEQlZDnxrU9sfcc9DwB8jexSalb7VE/z86xBKrk+UGOJxmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(5660300002)(86362001)(8676002)(66556008)(4326008)(66946007)(66476007)(9686003)(2906002)(8936002)(41300700001)(38100700002)(316002)(82960400001)(110136005)(83380400001)(26005)(6512007)(6666004)(478600001)(186003)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+M0dcnX/yhSPLTVvMEJkMfFnBJWIBVJlSxYM30j065qowMQk/c5ieiE4wee8?=
 =?us-ascii?Q?rhhVOJd9Ur/5y9QbCYvX5gLqOEAzE6bLV1yGhbnZXkfpD74H9BoxKo/CX+9R?=
 =?us-ascii?Q?jg8TvhuSRHmm7Bq7rHFqsgOQwfJfyIV7up9f4H8mFTul7KTLs60V1tcqYcbr?=
 =?us-ascii?Q?hEhIMRrE5YZYX7msWLvFv4XXqnUhsyYEHaU7SRyW1ellV1rm4ETRhve6ufOl?=
 =?us-ascii?Q?TkhPpx2Ojn6+zi3WfutWxWHkOBveaB9Sc+9VA9va1qLK7vTwMiyVqsongAJt?=
 =?us-ascii?Q?3ldyVHsF3AZMgBD81JuvK2gHmnmKhnikeoflyN1vBb2bR5HbuH95IUAMPPtm?=
 =?us-ascii?Q?KSQvqpIxRUxwtLRM7E6y6UIuV/BdRCSC4+wi+bPCcawkk25kkLxjLfAlAm6I?=
 =?us-ascii?Q?hgpfMbbSkSJeK08/GJY1XGGjysl2BsXfY1QtxAjj40EIT87EQjNllADgfdfl?=
 =?us-ascii?Q?iGzldFC+CjD0HY+N6g5WeHMClqszETyBTbnNFo6Pb3EmuxafqxuhrFqTb3P5?=
 =?us-ascii?Q?Y5zLoEY9R94hr8KqQWa6cTM82Hwc+dK+fJoFtMdLMRUY4qxJgXSI9FWRpX9j?=
 =?us-ascii?Q?4+BGz5ZzeT6DzoIKSTe3HoEUXKIhgoxI6jBNFuIUwyZF93GRD6qqCsaitUHU?=
 =?us-ascii?Q?5uwjS2PP3UFpwWQPBeg8PEKxADPRI7c+RVY7AbOBfJqxVvx42ACgaxtTV62L?=
 =?us-ascii?Q?VCfFTNl5r1munvTK1z5N6mMBWmOadF1c/rJ2jYfdIUGwrc8m/70C5YTrzBF9?=
 =?us-ascii?Q?lXIoCnPLDaKox+fiIsLINc94KeF8WJzGdTaEP0u2tBqGOiO25QXPDd55Finl?=
 =?us-ascii?Q?Ajszz05k5xs6p6YWOeTtVCGkyJNT4X7AWqOEZw8b28TDBOCooDh7rWzOszdK?=
 =?us-ascii?Q?zETeno0TLSD7Py1zetX1jXt1yfThtkV20pWoPKaaGg4U62VSNuaqBQueDyeM?=
 =?us-ascii?Q?vFWIHt/UiO1mewdPcotmQrTHIJLuOgMVLefJ+mQBlV6AiOulRbGaBoxFp0Po?=
 =?us-ascii?Q?54miL6DwIKpY1nXuARsZ7s8SsQ1JfbCIQLdFaAIvT9CpOF2Cy3nDAGuIy4Ue?=
 =?us-ascii?Q?fyvpsigQXVMpTDaBEqljkKyxc+AyAzp7KMlXRRBvZyoI3cJhIZp6SADxd6cL?=
 =?us-ascii?Q?zv5aRqoDh7W0wy3N1wQ4kOyoDfgjpsTkYehNrUeMMQC4my8tfoAaBBSjOzQP?=
 =?us-ascii?Q?lgyh4prbUnIqdignErT2WZRH2WcXlobuzqcxA/IKQ9WwwqmzuhZ2s8/NB1B3?=
 =?us-ascii?Q?w+B00AoFVf3JHzQVdBfweblZP7sUENAXVhEXEyxu7M46wUKtrAeahMRPlq6G?=
 =?us-ascii?Q?QcyPr7WDNt13QNZZC3J1769+lfAkt6n/eQsQ3TtdVzmjz7MzBsBeDv1GtTGe?=
 =?us-ascii?Q?2JMlr7gjdXY6JmINrRLmjdF8CbyvQb1sGqyPIEdOx9QLYvYMgNCYAQin8e0g?=
 =?us-ascii?Q?dy7W7mww+MkeaVnTDuKkcA4+KHOokOAuP5VLBoo/4hxEBd6xO7qHo6q3Ndzy?=
 =?us-ascii?Q?4+kK4KVqVi/nU3MEejINGuh/in4VnRg7T8V0YgAShG6LC9t0niUHXlIju8WB?=
 =?us-ascii?Q?eTSKciDt/yiniPCkFz+//ae6oFZ7tlDvBUnBZoX4o0GxhyxWMe00lr0rm10D?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b82b6948-69af-4a18-00b6-08dad898f604
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 21:21:10.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfntmKEBPcWpaFaaNT/xfVhM8IZC4MtLxFdecW2+s33XUCPvH6x0SvxBew+1JOr+2gUrJ7XQrJEzG5ew5/TqftvSuNr5FIAnEnuJK/R69FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Tue, 06 Dec 2022, Dan Williams wrote:
> 
> >One of the recent revelations with this patch:
> >
> >https://lore.kernel.org/linux-cxl/167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com/
> >
> >...is that commands that are not meant to be called from userspace
> >should simply never appear in CXL_CMDS nor cxl_mem_commands. The
> >motivation for defining SCAN_MEDIA and friends was to use their
> >definitions to block the RAW command passthrough, but ironically that
> >enables the ioctl path which is also unwanted.
> >
> >So I think this patchset first needs to mark those uapi command numbers
> >deprecated. Then ensure that all other background commands can not be
> >submitted via the ioctl path.
> 
> Ok I will have a look.
> 
> >
> >>	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> >>	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
> >>	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
> >> @@ -145,6 +151,136 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
> >>	return cxl_command_names[c->info.id].name;
> >>  }
> >>
> >> +static unsigned long __maybe_unused
> >> +cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
> >> +{
> >> +	struct cxl_mem_command *c;
> >> +	unsigned long ret = 0;
> >> +
> >> +	c = cxl_mem_find_command(opcode);
> >
> >Per that change above, cxl_mem_find_command() is only for the uapi.
> >
> >> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
> >> +		dev_WARN_ONCE(cxlds->dev, true,
> >> +			      "Not a background command\n");
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (c->bgops && c->bgops->delay)
> >> +		ret = c->bgops->delay(cxlds);
> >> +
> >> +	return ret * HZ;
> >> +}
> >
> >In general I worry that this is a bit too flexible. Instead of callback
> >ops I think this wants to be straight line code with something like a
> >poll_interval argument in 'struct cxl_mbox_cmd' where 0 means the
> >command is immediate and non-zero is a number of jiffies between
> >background operation polling intervals.
> 
> Are you refering _only_ to the delay callback being too flexible or the
> the whole set of callbacks? If only delay, I don't like the idea of
> having a poll_interval argument *and* a bgops structure with post and
> conflicts callbacks. We could also move conflicts functionality to
> another argument in cxl_mbox_cmd structure, but not delay functionality,
> which makes consolidating everything in a callback structure nicer imo.

I am refering to all of the callback operations, because the callback
design assumes that the CXL specification actually defined a functional
background command facility which it did not. A functional background
mechanism would arrange for queueing to overlap with result reaping,
like an NVME ring buffer*. As it stands the driver needs to be careful to
reap previous results before issuing the next command which complicates
the implementation for little benefit.

A straight-line implementation eliminates the conflict concept. It moves
the details to the caller about how to time-slice the operation, or in
the case of overwrite, allow it monopolize the mailbox since the device
is effectively dead during the overwrite.

---

* it turns out the Bind vPPB command got this right. The command
completion is queued to an event not to the singular background command
status that needs collision protection.

> 
> >
> >> +
> >> +static void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds,
> >> +				u16 opcode, bool success)
> >> +{
> >> +	struct cxl_mem_command *c;
> >> +
> >> +	c = cxl_mem_find_command(opcode);
> >> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
> >> +		dev_WARN_ONCE(cxlds->dev, true,
> >> +			      "Not a background command\n");
> >> +		return;
> >> +	}
> >> +
> >> +	if (c->bgops && c->bgops->post)
> >> +		c->bgops->post(cxlds, success);
> >> +}
> >> +
> >> +/*
> >> + * Ensure that ->mbox_send(@new) can run safely when a background
> >> + * command is running. If so, returns zero, otherwise error.
> >> + *
> >> + * check 1. bg cmd running. If not running it is fine to
> >> + *	    send any command. If one is running then there
> >> + *	    may be restrictions.
> >> + * check 2. @new incoming command is capable of running
> >> + *          in the background. If there is an in-flight bg
> >> + *          operation, all these are forbidden as we need
> >> + *          to serialize when polling.
> >> + * check 3. @new incoming command is not blacklisted by the
> >> + *          current running command.
> >> + */
> >> +static int __maybe_unused
> >> +cxl_mbox_check_cmd_bgcmd(struct cxl_dev_state *cxlds, u16 new)
> >> +{
> >> +	struct cxl_mem_command *c;
> >> +
> >> +	/* 1 */
> >> +	if (likely(!cxl_mbox_bgcmd_running(cxlds)))
> >> +		return 0;
> >> +
> >> +	c = cxl_mem_find_command(new);
> >> +	if (!c)
> >> +		return -EINVAL;
> >> +
> >> +	/* 2 */
> >> +	if (c->flags & CXL_CMD_FLAG_BACKGROUND)
> >> +		return -EBUSY;
> >> +
> >> +	/* 3 */
> >> +	if (c->bgops && c->bgops->conflicts)
> >> +		return c->bgops->conflicts(new);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/*
> >> + * Background operation polling mode.
> >> + */
> >> +void cxl_mbox_bgcmd_work(struct work_struct *work)
> >
> >Is a workqueue needed? If the goal is to make it so that all the kernel
> >background command use cases chop up their work so that one command can
> >not monopolize the mailbox for a long amount of time then the
> >implementation can also assume that foreground commands that collide
> >with an in-flight background operation can just wait synchronously for
> >their time slice.
> >
> >That makes the handling simple, acquire lock, poll for completion,
> >and everyone else just queues up on the lock.
> 
> I don't see how associating a lock to the bg op will make it simpler. I
> happen to think that my approach is simpler than anything involving locking.
> I'll explore getting rid of the wq in favor of per-device as suggested by
> Dave, but fundamentally would be along the same lines.
> 
> If we really want to make things simple, than maybe just not supporting
> polling would be better - I assume most devices will have irq support
> anyway.

Hmm, I'm just not (yet) grokking how the callbacks or irq support
simplify the implementation. Perhaps I can explain better in code...

I see irq support as a small incremental extension of polling support,
not something that precludes polling support. For example (untested /
unfinished):

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3a66aadb4df0..30b21ae4cbe5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -178,6 +178,19 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
        mbox_cmd->return_code =
                FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
+       if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
+               int i;
+
+               for (i = 0; i < mbox_cmd->poll_count; i++)
+                       rc = wait_event_interruptible_timeout(
+                               &mbox_wait, cxl_background_complete(cxlds),
+                               mbox_cmd->poll_interval);
+
+               if (!cxl_background_complete(cxlds))
+                       cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
+                                   "background timeout");
+       }
+
        if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
                dev_dbg(dev, "Mailbox operation had an error: %s\n",
                        cxl_mbox_cmd_rc2str(mbox_cmd));

...where all irq support adds is a small handler that does:

    wake_up(&mbox_wait);
    return IRQ_HANDLED;

...to short-circuit the wait in __cxl_pci_mbox_send_cmd().

The cxl_internal_send_cmd() caller gets a synchronous response and can
handle it from there. No need for conflict detection nor async execution
contexts. Caller is responsible for making sure ->poll_count and
->poll_interval are reasonable.

> 
> ...
> 
> >> +	/*
> >> +	 * With bg polling this can overlap a scenario where the
> >> +	 * hardware can receive new requests but the driver is
> >> +	 * not ready. Handle accordingly.
> >> +	 */
> >> +	if (!cxlds->mbox_irq) {
> >> +		rc = cxl_mbox_check_cmd_bgcmd(cxlds, opcode);
> >> +		if (rc)
> >> +			return rc;
> >> +	}
> >
> >Can't happen with the straight-line approach as all an interrupt will do
> >is wake up a wait_event_timeout() instance for the currently executing
> >background command.
> 
> I don't follow here. Upon mbox irq support, getting an irq will have have
> the isr simply do a:
> 
>      cxl_mbox_bgcmd_post();
>      put_device(cxlds->dev);

Side comment: an isr should never need put_device() because the irq must
be shutdown before the device is unregistered.

>      cxl_mbox_bgcmd_done(cxlds);

The complexity I see here is the synchronization needed to make sure
that the isr is aligned with the current background command queued for
execution and in turn synchronized with incoming commands. My
observation is that current mailbox state synchronization is
sufficient for:

- Transfer FW: broken up into multiple transfers
- Scan Media: broken up by Scan Media Physical Address Length values
  that try to get the Estimated Scan Media Time below
  CXL_MAILBOX_TIMEOUT_MS per iteration.
- Sanitize: the device is effectively dead during this operation, so
  there is little need to time-share

I do have questions about:

- Activate FW: not clear how long an activation could take in the online
  case, and no way to minimize it. Might be something that ends up being
  handled by Documentation about specific device behavior.
- Populate Log: ugh, any log for any reason for an indefinite amount of
  time. This one needs an example use case of what the kernel would do
  with it.
- Maintenance: I think this is in the same category as Sanitize in terms
  of recovery of a failed / offline device where command collisions do
  not matter.

...but I do not see those questions as prohibitive to the one-at-a-time
approach for the commands that are going to be enabled in the kernel in
the near to medium term.

> 
>      return IRQ_HANDLED;
> 
> ... to terminate the bg command and no wakeup is needed. But polling won't
> be able to do this hence the check above. Maybe I'm just missing your point.
> 
> Thanks,
> Davidlohr


