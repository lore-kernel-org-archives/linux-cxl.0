Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE672EB64DC
	for <linux-cxl@archiver.kernel.org>; Sun, 25 Jun 2023 22:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjFYWN3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 25 Jun 2023 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFYWN2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 25 Jun 2023 18:13:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8042D1A5
        for <linux-cxl@vger.kernel.org>; Sun, 25 Jun 2023 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687731207; x=1719267207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gt3H/3jBKZ2bWZOLluqt6an4mJ9b9x/JgQeFTnLHlDQ=;
  b=eeuToCXGqs7lr6GqBsLoEGr9C+c9NnaR53iDt0ozJyD8RtUoD6600gPU
   fk2ozvZpyHzEDJJ5YeL0nIy5YqmIFpTUH32R2hGYpH0lXg10In2QNvfnX
   gltCBMfPoYvc7YT2BzFY6sA+MMZfWzGBh21lm+F6XAV5UAGMCb6cIsR7T
   cztguULnatpBuKAzb53CZApve4Iex+jGYnq0F2tN18RQvfviJUb0z5TFt
   rDS7jHmCmB45kMKECF0pmT9+3ZO3pw9lvw4iYMhegaIXNGGTji9hYLGd9
   pvOE3pneQ15gWdcuWWaRDaQmzMAYk1WWXsDG/xU5So4ajIynfvmKRHlVn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="359991122"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="359991122"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 15:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="781193058"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="781193058"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2023 15:13:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 15:13:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 15:13:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 15:13:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 15:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUpuMA7HSyaHLflPgq1eq8nHlh+/9CG7MwuHEqyMhYSyLt0dwUbpJM1ffoqtzm3D90pXdDSvglp0jsmDL7u1FJQhfpPb/3aA94CUGxMtNIUeLcv9Vy7W3xgJR+fTLTje5E9tYGwCIvMXpGalc5at4hdVRvK4V+4uxLWtsQVSHA+bA69Lrat5qxTHyVyVqSnZT9RFCd05cBYl9sRb7SJBD/m6yyT9QvP6yzYKlDNL0rFD1u6NFSBZzM+/iJdpiu2jP4S5HZ95E3P9+dKBwd+ozSVZSYWVpR+JMYxFvblmqXJA2ZlbPrQuJVqg5RTbNkI6Dg4UMJ77h07Yv6yroo/YTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUY+7SQ8Dy+JfCsNZcbzd2vFE07DmRJIaEvBMWgcUDw=;
 b=Om+GZPqFwzvuZ7M94ejIhbfNzRsKIyTs4V7pFJ06WM8JwKehekKU91Er8jRbOcZh0ymq+TrWsQmWr7oD0pRSb85k/OAJEtrIopgDVALvtEBuN9kJIvJ7xiDUV8Wq2Ang+y+QFWp//SAS6qzGjqNffgLe66yhlYmrLBSFfXifOk89jtn1AhMZqyee/jviFVxnzRD5pDurkS7u8GDvoMdM8N1wnFEr1n8QfBiIe8UyUz0bb8JY8gNs56cp262BtAlhh0oP+cFHy6Wj/ievB3nHYvh7eeg+aKrqQ1g0ec5ozQA2urNqxfLnxc8rdBXFtz8iL6oVk1jg95pI0tbPoA52/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 22:13:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 22:13:20 +0000
Date:   Sun, 25 Jun 2023 15:13:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <vishal.l.verma@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <6498bbfb35c6f_2ed72947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230612181038.14421-4-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230612181038.14421-4-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:303:b5::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ddfe12-dbf3-4f26-2c3c-08db75c961ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFss+4iEFUInR3MDxn9ylqeg2Vrn8W8J/VVLRJxZBVeOkxN1MakQmwtfymdUfwr5xuzGMuSj05iJX///n0Iaq+waGS8UXRCAQbT8I5H9zBwmEcLwZ1tiuta+Gt+n01L+u8aOrOfJptAlM35AzR0r9PflLb9FYwU8nTE9E7Cay7EOtA4jIJhOzPAyf0qlfXM4/gwsZLclPWZOQqm1rKm4cDz3qxVOddomTzou2scb7AWZ9pDWAVmarOxRc6JFQArH2lpI2l6e2dDCg1rHwEVb8IKUWFjj3xoQKwe+X8eT+EY2SJ0Zkialr51/Zg5TMhkUdVvRne7tQYZJcVve+I7SMANTMPZAJigk2dHSE+N8c7M757JcFhtbchhApPj07hiOL83wXDIBlXctAfnhgb/pieYWFE4FMWwKoEiijN68Ssg7rVAZyKceMtNMZatJ162c9rSkcaEPyPmQmZ31V0jKP1s1NEiKVd6DEflFvn931A4UiDXEGsjh26D7nPzZ6GobK7ClFIG3lZPjZ1RtFunDWQ078YkXLwIySrN3sMO0Bu8VUHRVqLx+BK2Ay7rEVB6q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(26005)(5660300002)(66476007)(8936002)(66556008)(8676002)(4326008)(86362001)(41300700001)(38100700002)(316002)(66946007)(82960400001)(6506007)(2906002)(6512007)(6486002)(9686003)(186003)(6666004)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cvRxKhO8Od2Kx37d7ubYFZflEGk+VZ3SVLg/REKIC6V4SJ4CcJj+Zyy6+Vd?=
 =?us-ascii?Q?rzzvYP0Qq/lvd+K2UPIAJny/BPudDvzDmXZ66B6kfblnetRJPlU4D5aFQNkG?=
 =?us-ascii?Q?Itmk+2cQyM1EexZ8SJFsljQtPIdbSvusXbO2aIG0RhHR2DB6pTbo01YHsx0+?=
 =?us-ascii?Q?308KPrUH32x7VeUN/1X8XgJSte0ls9M+0a63hz5k/y7pIKwQlldchY+s5wUx?=
 =?us-ascii?Q?LC6o6v5D49CB0cMJgf8li1XKVKZPI47NcEsos+FYq7PzoGeiTDoyIEQHs3fI?=
 =?us-ascii?Q?IdQp2v057tGZwg+X1vJQCZWWoc25F3j+M2V3xmb3vzjli7fzwfPKiZePMS9S?=
 =?us-ascii?Q?1/PrVgfyzqumHqaZHdlIcwaAj4rSdli3Asnl6s1j7H4i5OBu7HCOeuavgf1b?=
 =?us-ascii?Q?dB4mE6lbj0NSWh489JUY60LNVpiTbrQtunsyDYGxocruXNexoT6acV7E5MCp?=
 =?us-ascii?Q?yD+4uj3PyA3Q+k0R/UH59TEaTAcCe/efOz0UomZtrX2i1JIjuQKwnkK9F2xe?=
 =?us-ascii?Q?PreaD67shxajcMybrLRUstBa3v3Sr76ezSjp1Mn4DRGBqKWwbW+hTmWfw2PP?=
 =?us-ascii?Q?R2JeFQmZJ5HECBpf/6WhKMBcgwIDkfaglssal5YfLZn48Ga4UluYRN+nHTvo?=
 =?us-ascii?Q?Ryv+97QlLYHNvCdS5GxgYSXlbEjOevUMh6RlRALlQidy0KsGgwWAjA3c0cZj?=
 =?us-ascii?Q?bstVmNfq94l8yIfxq4XycB7rmvQuOqCwtwJ6Z6ejXW4OtUeXfwp7nbpY32Jk?=
 =?us-ascii?Q?lUkSiRZMj7kF+QL5LbY0VLQwe8dL11gOTrnaZf/k/rz3zwo/7ColEfC4Z1Ga?=
 =?us-ascii?Q?RYIEobYm5tFQs5r4bOq/0Q5dyRTg6f7a3KicIhc3cen7kkpk/k/1NYsHHYi/?=
 =?us-ascii?Q?eS5Pj6E0+l4Nft9leDRxkXuCjYMotpfH5dJ/Jk9CYBOTllBMBX3QOk/IFiJc?=
 =?us-ascii?Q?Ix0oV87y7gt/ujh5jiZYHgIczjv86X4EOrRIg0FbHxim9ATjlfjyhEQFqIAD?=
 =?us-ascii?Q?idk1sggXoZiCDzcZIwcMN9aBqO27Sk58N80C6RFUtdi5rdW4ISbgsDz83Vsg?=
 =?us-ascii?Q?5TqAivZ7fSD3PiEI+7BZuIRMm6JQXT8iXpXWlTuQIiQ3GGJLNbQSKsfk3Cei?=
 =?us-ascii?Q?1MN6tiyxC9JRQiOpIpFynshyMZlJSXiA48gB+TTd7rGvJnAZSezqJN4sCPTW?=
 =?us-ascii?Q?9k93XrTlX17Z5SyhiMk0Ps1a+fesk5Z46SmwzTUnsBfSPV4Oa06Qfdwkklx/?=
 =?us-ascii?Q?aA+s3w/KCRKs7FenXxUJU+fZtb5AcNHGh3DlkeakmCz6RggGWuuSVUHQnYm0?=
 =?us-ascii?Q?YMDv6fJyMEJNy72ZuJ7vqg1Iy04ZrsWT2DBLA4IkVGuf7DiWldE3E2RN7mQR?=
 =?us-ascii?Q?CsGHrqOjP/R6v8V8uPhP8Ef8ZZ7BqVyiRNregxYHZG5PZkuMhFePSX4d2wLP?=
 =?us-ascii?Q?LuUvR/6AViHhoEWS30mF1uroDO1D3i5EA8U8y5/iKkVjPNa0XHTYV2Cd7Ckq?=
 =?us-ascii?Q?l/SjdZR/oMqi0NUa299R4en8za5T3gXLhI69wwFFYbbcxG9TGYH6fEyl+46j?=
 =?us-ascii?Q?P7H7MRLl7wSzB+m+oLcpJmpCxxT9Zrz7mYLJUe9qvIqou82XB2Zwk+KlxtVD?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ddfe12-dbf3-4f26-2c3c-08db75c961ec
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 22:13:19.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYHJefROmJU/276wDgg+EfRJ4qV+ImvAoQcI+L4N03SJNPlp2FcEtzvlEmtuHx1Vlry6tzryNZkZC/lsCRbDuXSRV74UyoB2ess1sE8wwhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Sanitation is by definition a device-monopolizing operation, and thus
> the timeslicing rules for other background commands do not apply.
> As such handle this special case asynchronously and return immediately.
> Subsequent changes will allow completion to be pollable from userspace
> via a sysfs file interface.
> 
> For devices that don't support interrupts for notifying background
> command completion, self-poll with the caveat that the poller can
> be out of sync with the ready hardware, and therefore care must be
> taken to not allow any new commands to go through until the poller
> sees the hw completion. The poller takes the mbox_mutex to stabilize
> the flagging, minimizing any runtime overhead in the send path to
> check for 'sanitize_tmo' for uncommon poll scenarios.
> 
> The irq case is much simpler as hardware will serialize/error
> appropriately.

Some minor things to fixup below, if this is all I find I can likely
handle this on applying:

> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/memdev.c | 10 +++++
>  drivers/cxl/cxlmem.h      |  7 ++++
>  drivers/cxl/pci.c         | 77 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 1bbb7e39fc93..834f418b6bcb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -460,11 +460,21 @@ void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cm
>  }
>  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
>  
> +static void cxl_memdev_security_shutdown(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (cxlds->security.poll)
> +		cancel_delayed_work_sync(&cxlds->security.poll_dwork);
> +}
> +
>  static void cxl_memdev_shutdown(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
>  	down_write(&cxl_memdev_rwsem);
> +	cxl_memdev_security_shutdown(dev);
>  	cxlmd->cxlds = NULL;
>  	up_write(&cxl_memdev_rwsem);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 091f1200736b..3a9df1044144 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -264,9 +264,15 @@ struct cxl_poison_state {
>   * struct cxl_security_state - Device security state
>   *
>   * @state: state of last security operation
> + * @poll: polling for sanitation is enabled, device has no mbox irq support
> + * @poll_tmo_secs: polling timeout
> + * @poll_dwork: polling work item
>   */
>  struct cxl_security_state {
>  	unsigned long state;
> +	bool poll;
> +	int poll_tmo_secs;
> +	struct delayed_work poll_dwork;
>  };
>  
>  /**
> @@ -379,6 +385,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4b2575502f49..c92eab55a5a7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -115,18 +115,52 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>  
>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  {
> +	u64 reg;
> +	u16 opcode;
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  
>  	if (!cxl_mbox_background_complete(cxlds))
>  		return IRQ_NONE;
>  
> -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	rcuwait_wake_up(&cxlds->mbox_wait);
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> +	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +		rcuwait_wake_up(&cxlds->mbox_wait);

Just a question, is there any harm in awaking this even though nothing
is waiting? I.e. just wondering if this has functional purpose or is
just for cleanliness?

> +	}
>  
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * Sanitation operation polling mode.
> + */
> +static void cxl_mbox_sanitize_work(struct work_struct *work)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = container_of(work,
> +			     struct cxl_dev_state, security.poll_dwork.work);
> +
> +	mutex_lock(&cxlds->mbox_mutex);
> +	if (cxl_mbox_background_complete(cxlds)) {
> +		cxlds->security.poll_tmo_secs = 0;
> +		put_device(cxlds->dev);
> +
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		int timeout = cxlds->security.poll_tmo_secs + 10;
> +
> +		cxlds->security.poll_tmo_secs = min(15 * 60, timeout);
> +		queue_delayed_work(system_wq, &cxlds->security.poll_dwork,
> +				   timeout * HZ);
> +	}
> +	mutex_unlock(&cxlds->mbox_mutex);
> +}
> +
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @cxlds: The device state to communicate with.
> @@ -187,6 +221,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * With sanitize polling, hardware might be done and the poller still
> +	 * not be in sync. Ensure no new command comes in until so. Keep the
> +	 * hardware semantics and only allow device health status.
> +	 */
> +	if (unlikely(cxlds->security.poll_tmo_secs > 0)) {

CPUs and compilers do a decent job at likely/unlikely branch prediction,
and given mailbox operations are a slow path I can not imagine this
unlikely() annotation makes any measurable difference.

> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
> +			return -EBUSY;
> +	}
> +
>  	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>  			     mbox_cmd->opcode);
>  	if (mbox_cmd->size_in) {
> @@ -235,11 +279,34 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	 */
>  	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>  		u64 bg_status_reg;
> -		int i, timeout = mbox_cmd->poll_interval_ms;
> +		int i, timeout;
> +
> +		/*
> ++		 * Sanitation is a special case which monopolizes the device

   ^ extra '+' character?

> +		 * and cannot be timesliced. Handle asynchronously instead,
> +		 * and allow userspace to poll(2) for completion.
> +		 */
> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> +			if (cxlds->security.poll_tmo_secs != -1) {
> +				/* hold the device throughout */
> +				get_device(cxlds->dev);
> +
> +				/* give first timeout a second */
> +				timeout = 1;
> +				cxlds->security.poll_tmo_secs = timeout;
> +				queue_delayed_work(system_wq,
> +						   &cxlds->security.poll_dwork,
> +						   timeout * HZ);
> +			}
> +
> +			dev_dbg(dev, "Sanitation operation started\n");
> +			goto success;
> +		}
>  
>  		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>  			mbox_cmd->opcode);
>  
> +		timeout = mbox_cmd->poll_interval_ms;
>  		for (i = 0; i < mbox_cmd->poll_count; i++) {
>  			if (rcuwait_wait_event_timeout(&cxlds->mbox_wait,
>  				       cxl_mbox_background_complete(cxlds),
> @@ -270,6 +337,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  		return 0; /* completed but caller must check return_code */
>  	}
>  
> +success:
>  	/* #7 */
>  	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>  	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> @@ -382,6 +450,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	}
>  
>  mbox_poll:
> +	cxlds->security.poll = true;
> +	INIT_DELAYED_WORK(&cxlds->security.poll_dwork, cxl_mbox_sanitize_work);
> +
>  	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>  	return 0;
>  }
> -- 
> 2.41.0
> 


