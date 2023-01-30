Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C00C636D3
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 19:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbjA3TnI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjA3TnG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 14:43:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2111E98
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675107785; x=1706643785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NJ6eWUj5Eh66FrqiL0wMBuSrA1DRmGnEz00F5lu8wuI=;
  b=gmdL7keL8S8bbGtfuxPw+FPl1qbwTXn4hqVt8Jf7yomeJnLGb2GF6t0Y
   WmWz37nAazdREain0Z2eRECF6bwfbpUefsDVBkPmnuwZ4Jtu1GfJWT/Tc
   GsNse54/4WhRDKhg98VaprASg2AQjnPcFMjQjyjiDw3dqT9eI2zexUwQF
   xetsQHYAZkn4eFkUEaVNqDm+wAyT9+9o3e6GJTagULcOaV6VUMdXqNf/E
   T8hLZ+LYQKwoHyvB4whyMrvrN6Gfv1oSn/I6+iAex7KAmhlxxhrziJrHG
   0VHzoQqXKTOaZnBbhtCI38l/2QCrbvbSAC+9qpk9erKof9GVr+ePZR9bJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327676225"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="327676225"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="806810651"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="806810651"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2023 11:43:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:43:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 11:43:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 11:43:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDOcXLnvx2E5gxpfDhFKNknIMW8zsYl8F4QJrNTHUCIz8eMLDGcq7bfJ4CtpWgfN/ii0TKF+tZKSKRrVizN9VAwuXFW6Sv2ck9nAKbFYzqeYbNNflRx675jKWiVYt+Fnfedmw280/s7nFWfimQ5Ebf7HyyHWtcVfffferSDQS7yLXa7IJnxnqwBB8DL8zXTShP2cAB+6qH+AZ7W1rux8T44REOYH5V4IpjganXeUpFQV8oCg7vvj+RjdYY0k+E6kwxwB4zGFtR15sRRs4i5FeqxriD6MBbNfgkRJqTx0wi2+9VNT3K1PPN0Tnyr0v2Pz3330gk24z7dkFtx1rojM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zqu1pci5BJigjdr1hrfUYnO/iSWWMn1AC/evDbeuzY=;
 b=FgMQ4zglzrjO1FkZ2jkPkpr/vGfVUnOHWEy9tTWSuJrmaUHHNcFW63AsT7W46xj8Bx/n1FyoRPnRUISyE37VpQ7ycSb4zYnKhS2vrmSVT7Dmw5UJSTEx0PR3hxZdwYM7m0TAkmlrLLn2M13DD0tZxuTjojs6IUvcIQO3HCwwEu3XYJU4kECI3Q3fQOZCL2HoiHiZXZrAXFLQtxi0aue8dg62LRjpkd4fQ0cCrif0yirdEVaVHdjPNOwDMxSBvTtATD6KgKolRZv6VpVLA/LErQdsl0eu+ZLAcRn1ylK7p+YWU8JGGhQtlyYbv2DRM7syG9hnI96+8KzbjBnsL4Zu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 19:43:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Mon, 30 Jan 2023
 19:43:00 +0000
Date:   Mon, 30 Jan 2023 11:42:57 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Robert Richter" <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <63d81dc17dcd0_3a36e5294db@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
 <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
 <20230130150633.00005cd2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230130150633.00005cd2@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c031c6-a336-4b40-9a57-08db02fa31a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdA5Xj3hqN0KBw/zONUNP1PZfnACmuBLzuYXb+3jaRZD/9exJvRPLrzBSX0yfPiTA6ec3rdePEI9yUDc4whz+VdHnSV7GkQyiXNHQft0XEwNpdG7pvP2QDCURXkVmM/MhbONpYE4jhCs14w+0cmiW830QnYF9mkqUx9Z872f+/+s8/3kAIJcwrpIJxQ7sl/q9A6SMpl6f7mVQ5p3JEMTLVPozRcyZR4acK8cm/9YfPVJ/DlNnjXY1xLy5f5u6hn4vRhqLV3gT/79qbvkNxU4HpHMeclP38UocjJ1TidNekyGPE2AChigorrkGvUu9OHC4IktEXSD2kyFZwpuWP4Thkju8W+z9cqZ9sFZdE6A3kI2jf/Mov/Elw1XCBQ8X5SQwsh2QaW2DSRYkRDIOQwk/qjb2I6Pz4FKXiFuB4SJTRNIoiYYWIH5U2qVt3DfLuSihhv8HESIqeSjgwmqbCnjj68oxiIJQSh297PpXbP+q2aqMPzKPDBvE/osH3vt6OGAjxWR3srDu4qdDS0nhX+CgCl0pk5aqyABStYU/TkkkEVvxWTDJai6buOzC0OYDTgS2Jk3ta7jymSlnUdgt3HsSfMyOSssDJ7qLN/z/FJCxxtNPPJ4BEe8FS6P1iwbq11V5qcXu+SvNsOxvVtITtwgMYW+tEGXPfu5XB73ruOZmhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199018)(83380400001)(186003)(54906003)(110136005)(26005)(9686003)(6512007)(316002)(2906002)(38100700002)(82960400001)(478600001)(8676002)(66556008)(66476007)(66946007)(86362001)(966005)(6666004)(6506007)(6486002)(4326008)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yv02jUWUuM7+WTa9blS/jHuvQCWocQ7foeunxoYQQ2tYZbZgcMNXGS9l5OkA?=
 =?us-ascii?Q?hWatPM/VuBI0bx2vURlqFUKBKR4mq6z6kz3k/uPXNEWYQ3lwhysaH2Lh12S+?=
 =?us-ascii?Q?+RgSr7sXJtukyjEPe1sCLGrO5n+aVZ4vZ56IvX2dfHXlbFINbYhST7++Kejw?=
 =?us-ascii?Q?f11xjFfs+4ZqbBycf+mZFDNjqsu5kEZJ2kkwj7TkndStwtCMqKplPh+LQF09?=
 =?us-ascii?Q?j7b7vlhJij/wdik4D85dAtn4xMZNFzjUgF7wH4mR8HRt37taWeSFhE/3k+jb?=
 =?us-ascii?Q?1xU+RcF5goRjHsFUtVz8jc1IzRxKwHTZSHV78+JIVKYElrq+wsUaH1yTmGzd?=
 =?us-ascii?Q?QeIkjln8U0d6CTNGB26Tn8Dgvuf+4vpKesXTCZgumDizyw85HvgmWpUzNd4m?=
 =?us-ascii?Q?SXEx8/QsbppIPqRVsw9YgObzUf8qcs2oFvu7kEwhTJzMa2OYHrPtUOWXd7gI?=
 =?us-ascii?Q?pQT3UzYm/jnbtC0VAP8w0PRZnXg+28HIMOjFoMOh9Y92f8MusrPRsndimMl2?=
 =?us-ascii?Q?MLqPMqQKwpTZhP3210New/cBYNQMVPD4HaAN/qu4bReBqE06ecjguVNUodh7?=
 =?us-ascii?Q?xBk9KlBOUSyNWBX635I1I2LiOK5u2kpoR7pcyZD02Q+bjwzxLl2J/wnqjEAh?=
 =?us-ascii?Q?2VGLKJKYNjhWbQJAX/xEnukMZNXvb/l2oJM5EFuPepCSMEg+y5vmz13JAA7/?=
 =?us-ascii?Q?hX+HMFPYc0sqqFgi6ZG94kNO1FoaERqh0RmWwdX3NCYzST3KIP/iDXvii9lp?=
 =?us-ascii?Q?k2WLZtwCEp8I8+eFHA28JrhXZLbCs4O/POsjrm3tKjXe7wnhxpjGXJNA53eI?=
 =?us-ascii?Q?Hp7YwDRHIPeOQ5tKEA0IzFJexR8uPNmqNfkG2qRBRQ2Sa4jPgnRhUlgHTRIW?=
 =?us-ascii?Q?MKIJ09LcJmzy8o5J7XhliuniJUuQAWU7NT8bPZcIX5JkOtwIPohUF2cAnOqC?=
 =?us-ascii?Q?Y24f3tBd8STQwGzgY8IvDlo/oiiiNmOsyUMJ3W8u9ef8fP2j2Xf+phMOeClM?=
 =?us-ascii?Q?h8Th0u3Ha46LDTKpMvHvWCJw9pCO0KleTVxkgq1jZyluRzk3rCQSfyMHy2wE?=
 =?us-ascii?Q?44/Hn39MPHIl1WA8h13bnzpTxNqSFq9CnD2DJPOGI6Z2iG6G2ra1ywSiKK31?=
 =?us-ascii?Q?G2mB3pHN+pkozgE/reC51DP5c9pTFTPE2BiAEVHg9QshEjEaailEEtYDVQwU?=
 =?us-ascii?Q?Cv1ODDQQuSFRJhRU2YOUJfRE4pGHvAZGKuOR45Fjlp2skNDUK/66k8yV96R/?=
 =?us-ascii?Q?5rYH/sIkZp0gaXW1bZ9uQ0zWiAHjVVdikUK6gPrVUBF9e6sTrFsv47WfZJjw?=
 =?us-ascii?Q?/6D+yYxTt8fZ5RGMyyM1GLHbT/EqUZ+gkmYTC+O/EElp+ZNUZuks6NlhM1TN?=
 =?us-ascii?Q?1wMqsYf2dTI2SB2fZS7fApp/x4ayquL+ci5bWgrGM/lD6Y3ZW6RLllkQe6ZK?=
 =?us-ascii?Q?voAYTjaJn/PaXo7talPYb5rj+skNVOTpji/yY6NA5X5/SmRzhjKs7Gq0/F8x?=
 =?us-ascii?Q?TnTX9ri81O2+DLBpcQxgZEEF4y6GMhZ/3eze7/gimAQRCoMyaXAT6Q4fpQAi?=
 =?us-ascii?Q?/kHHxkfugM0Y2zqTgjX7iZKiJKFrrFy3+GL0SvbI/kWKEjhknm9F2kMExGqa?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c031c6-a336-4b40-9a57-08db02fa31a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:43:00.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gI8xAX8Eto5pI+uaxsd3nArsjZVj8vyEM8azVG6FJgCyxUpJXCsRw1lzF7xFvasXvMmCC2Zv33qi9q1BOLWxVGqSJcLe5k522q+q2j/apvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 27 Jan 2023 18:06:43 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
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
> > 
> > I also think it is a bug that this command passes kernel internal flags
> > like CXL_CMD_FLAG_FORCE_ENABLE. So let's declare new flags in
> > include/uapi/linux/cxl_mem.h starting at BIT(1) and do something like:
> > 
> 
> So this is OK in that we are just adding more info in the flags
> field so backwards compatibility is better maintained than simply hiding
> commands.
> 
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
> 
> Good to add a comment on this flag.  I've been staring at it an can't
> figure out what it was ever for...

Oh, I just noticed that the kernel internal CXL_CMD_FLAG_FORCE_ENABLE
was being blindly copied out to userspace where it has no meaning. So
any new flags need to come after that one that is already burned.

> > +#define CXL_MEM_COMMAND_FLAG_ENABLED BIT(1)
> 
> ENABLED isn't the clearest naming... Perhaps _AVAILABLE_TO_USER
> or something like that would be easier?

Yes... but it is unavailable to the user when it is temporarily reserved
by the kernel in the next flag indication.
> 
> > +#define CXL_MEM_COMMAND_FLAG_EXCLUSIVE BIT(2)
> What does EXCLUSIVE mean to a userspace caller?  EXCLUSIVE to whom?
> 
> Other than bikeshedding this looks good to me.

How about USER_ENABLED and KERNEL_RESERVED? With some docs:

/*
 * Older kernels leaked an internal flag at this bit position, that flag
 * is not relevant to userspace. Newer kernels set it to zero.
 */
#define CXL_MEM_COMMAND_FLAG_RESERVED BIT(0)

/*
 * The given command id is supported by the driver and is supported by a
 * related opcode on the device.
 */
#define CXL_MEM_COMMAND_FLAG_USER_ENABLED BIT(1)

/*
 * Requests with the given command id will terminate with EBUSY as the
 * kernel actively owns management of the given resource. For example,
 * the label-storage-area can not be written while the kernel is
 * actively managing that space.
 */
#define CXL_MEM_COMMAND_FLAG_KERNEL_RESERVED BIT(2)
