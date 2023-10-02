Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A6E748F8
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 16:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbjJBQso (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbjJBQsm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 12:48:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F6CA7
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696265319; x=1727801319;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r3OPFWVkbf8yuHKwKyt+BFtZX5Cow3goPIf66QUuJV0=;
  b=laxCkFzvc5RPQ6QemPPTepYhYwJaqlFDcvtrejMNf2QWnJk6//ZI98KO
   +q6kN4lOj98S0IS4F7cAsLUO1zBBy3EGGgDi6A9DRwkF7GoNQRtdMfhqt
   nSCQ8CIlSyKaBb1562FECUY4i4n+FF9G3/seOin+Oe8b+8+RXo7XgqWDm
   Mej+aDkNv48v+p2CNzWwK/LaJh5PJxq4/fbQeClgOL2IPvsGPTR3gbzQ1
   CzcVFAJY4Ag4eWm6yzTAQmMi7ZJg3rW9Cf/ha2zGNlhDWjOd+Ba5UIM3f
   FRHAXiAtsDNyhQbk63u/We5ZrJPw/pwgi3VSBi+gdx4Gmsg/3wUWvKq3u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382596977"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382596977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="894176307"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="894176307"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 09:47:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 09:48:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 09:48:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 09:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEqGdkEk8ARq69JD4YOobSzO6jVFWVLk4n2m3m1Iak+XDv7t5A2SL5hJUfDu8iKfzOTa6wR2pcQ82eQuwsCHXjRADL5ZlNsf0OmzxbFK8Tx6mXal60iyARFljHRLgwpJcDR5+xD/1ZPCnFt/C2eUX/Q8VtuwKjoa0i+/MDzEEOOWweDdtq8ViQaJLvlp/dv44y0vqDHEZaFo7aQnqDVo6HEYuaHV/8fmDQmUsmT8r4IwiH1WHTMXRiHebb7ViykIX2Am/glEOb+WtNq0F8T4JjkI4L4Z4KlLTymc63My8bpE3Ln+5r7iSzNNrShZCg5k6Ne4USj8ookHNi6CKDMyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyhZqcHoVrwhlSss8DwXZp62mqW/i6mJgxG7hOtTzzo=;
 b=FKVYuE5zOXPi/UCJAegueC5w/zHFGqMFj3ga69mj4SZrG/4mQ9qSICVSer4Ed1q5yRN6iruVjAYJTm9rbdyNaeiqj/v60tdVKQXp2sgo3YJMpxpLAwv1/mqAJ0KGzG8okHl88+CF1rHa5S4O6bnqPmhcWJamzfzKfbcpLERP8RcNj0+pNAD60hVxzgT44IjHPBYP+KTNxlajN3EAa1SvoJfMMzpSU3xtPtpKWhJ9sVb8v7E2HE87r/XF1MnQyXOpKBL1zVE0Wy1I8bKpoFnMQXZJ+pKYZe+36Kflx2TsvOXV/8nZ1ozhBwLkairXnMYIaPp6wZV3BCk1XD0k0oIePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 16:48:35 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 16:48:35 +0000
Message-ID: <a056b96f-2f73-4d0e-8947-be0d1e3eeb7a@intel.com>
Date:   Mon, 2 Oct 2023 09:48:31 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/4] cxl/pci: Remove unnecessary device reference
 management in sanitize work
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e36bc0a-4334-4cb3-5a3c-08dbc3676b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACKIIAD/gxWPtYXPPywkn5gMWIK24q44mhU0TNaLuT2hFHIiQ8U+7ue/008VPMMDgU8dKM3BB1d5QK27wxSOSekZMUhuu91vU4OcNVPrqHdjEHaQR4KbwwE1KE9g3iPVqr9YMJUWhdXv7JxOvdjP04qumL5of3gb0aovR0rzqysvel3lpyLdK5w5FtN06/WNCeF1Y5pKHyRQ68tBZbuHWT7A5CY31ju6lTLdXGW1yV92QDJuC6cRY3QeHj1oKVf2rcZHW9eciAq+Nib+0KKFvSXZxqKtaVit1gR/wzwfB75lMM6U5kukdGaLNAIDvYcwMd3DhZLCJ4Bq96CFqlwZ+hGpgg6Yoi6+cKGy4Q3nOBhk/WsLGWzJny464THpieOLElFNSejlwMbwU7ikXzj3R25W7qKIiyPM3wP372/yxCVPmIotJt+v/5KUXS2TrgRqXlWs+TzAksYEtb0gurc0NjK9tXNHpqwVQJFOaHWt3EKjM0KQZm96njlePYjTE0GlY4cohDZE/ul0RJA+kYcooIgItx50CjNtbwFKBa6txU742dtLLCnS2tK5yCZGUO14Ne54yDS1lRiRNH5/gG0Zq7kQIuqpnXjPFhWi6QdVUfRvtzTPLx1yWvY/IaTPgg0C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(53546011)(6666004)(38100700002)(82960400001)(83380400001)(316002)(66946007)(66476007)(8936002)(5660300002)(6506007)(6486002)(26005)(107886003)(4326008)(478600001)(66556008)(44832011)(2616005)(6512007)(2906002)(41300700001)(8676002)(36756003)(31696002)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNUTDF6RTlyQzF4cTVCa1dVWWhrRG9SWG12bnovM2U4djVHVXhtRG1rVFBR?=
 =?utf-8?B?aVZoUHE0VTNlTEY5cFpsdW94aVBVQ0o3MzNCYUN5RkJZaEI3YnMrQjk3S3NK?=
 =?utf-8?B?UUs2WXc2NWxCV016ZkkxUUg3ZFhmUmdhVHAvYVBDRkZPdm9RaHRld0NzUGRa?=
 =?utf-8?B?YWFycFZnYjRycE9LY0lSM1piNmtuRVNMS2hjd3ltV2VjeDFIbVFaZW1uNEtq?=
 =?utf-8?B?MjJ5bWdudU01R1BrdzJBUEdSL0tjRVNYUUMvb3lROTEycGNvVWNJdHRkSUdS?=
 =?utf-8?B?R1RyWFM3L1ErRmpmN21LVWQyM0RiYkhISjlCK3pQWkpqTVE1QmJoL1dLbFZa?=
 =?utf-8?B?YkltbjB5amZLblRNbVJnY2ROMlIraHdJRGJSTHlxckVXU2FoR011b29PQzF5?=
 =?utf-8?B?UFVFZnRtZkQxZXFHZEJkZTJmK0hiME1SUEEzcFdDK1VmU2JJWWlIUTdsaXJI?=
 =?utf-8?B?S3YzYWMydHA5dllpZkFaZFFyN010WURpdUhoQkxBUE9MU2xPY1Q2eUs5TGVV?=
 =?utf-8?B?OEhUTUpIekxIbmkzWWc2bVBheEJ4ckhiaWZlZms1WjM3OHBNZVhBdWc1bTdM?=
 =?utf-8?B?ZDUvVlFweHRWQ2dvSllpdGRCKzN6R1pHd2xrcDlVV1RTM251WXRjazJhVlRD?=
 =?utf-8?B?ajQ2VlBEZUxaZXlya2FhamdmSDhveEdVTktLVWFPU0grU1ZoNDdpRlFQSDVm?=
 =?utf-8?B?VElXcU9QZDg5MTZKT1lwNGdmOVoxTWNlRFI0dU5COWI2dHVnbWZmZDVOQjZy?=
 =?utf-8?B?WVlZbDBRVzlZU1F2dU5qNEdIZnFhRVYwQnAzT0ZibmhQTDMrSnFBUWpodDdw?=
 =?utf-8?B?OERVVGV2WllBdVloRXlOS2U3c2o1YXp2Ry9QZndlQWF1OWUvMElKK2NWTDFJ?=
 =?utf-8?B?SHowdFhrU1dkaW1QTWN0QURYVUpOU2Y2OXNrYm9MUE56bTVqb3kycFNKekpL?=
 =?utf-8?B?elJHVEg3RnpERWpHWXE4M1VjOE5HRlRBUkVDajJLV3d2dStvR0x1VE5mY0JN?=
 =?utf-8?B?czhRY0o3Rm53Q05WUmtubVlERktDOVVSWHkySDN2Tk0xYVJRMHdEOWtUYkN0?=
 =?utf-8?B?bTU3bExjK3FydFlselBlaGkxTk1HNDlRcXR3MHVvVXdJK0wvVTZ3T1gvL25K?=
 =?utf-8?B?Z3RvUGFkbnpWU1ZmRElVeXhCZTJsYmRsN1NJRWUyUTYwa3BRcVZIUEc4RVpY?=
 =?utf-8?B?U1o5QnZuSlF0WjF1YWpLNzlubHRPRWszcjJIamQ2dDE4TVMvbkVyeG5acFFl?=
 =?utf-8?B?QWlFeC93SVU1bkhINXZJUWNiVFVVeVJDek1JOEIrSUpmbS9ZNDlOZS9VOTdx?=
 =?utf-8?B?NHZHWWY0N0wyTFBRMXRNS2lYbmw0eHZVdzBlOU85cDBWb2lFTGprRnIxRURF?=
 =?utf-8?B?TTdWUGx5dHRpTWdlYVJqSnd3cXZkbG1PSlM2MlM3Q24vT3pBa0ZUSHFRbnJS?=
 =?utf-8?B?amVTeFVBL2hpL3ZIMDJXQyt5aEY2YzdiNjV6KzRWOU1ETE1KMm1aSE14NFNV?=
 =?utf-8?B?RnhROEp0eFQwR3kxSktPaDk1VDMzNDBMOUNFSGdLRHRWNGNUVW9MdFRxdEF1?=
 =?utf-8?B?R2lsZkh0Ym9idFVEWEsvYWhhZVVnay9IMDRMZVhuL0NPY3g0Y1hNVWQyWU5k?=
 =?utf-8?B?NzE5NUNiZ3RlVzdPY0lLR3pvK1dkZ3N2R1hxLzBUNWxxWlg1V1hIWWJtVlVR?=
 =?utf-8?B?VE5IdDU4VGhVdFRmTjNyVHZXMUt2cnIvQmJvalJVMVZOdzBURzNSZ3RBUWZz?=
 =?utf-8?B?T1FKZFc1Tk5IN2EwL2lnekNLTVZCN3JHSzBsRkdBbGUvam9XOHhVUEF5SCtG?=
 =?utf-8?B?djI4dzdDaUdzODZPNU1wZDNBcC9RVDNyWmpTMUMwY3B3OEJHazRZRnFzc0Fx?=
 =?utf-8?B?RWZKcUphWGxBWjVXWlRaS3FJVFdRbGd3ajM2ZHc5UlhZcTA3dlpRYVRqUlVP?=
 =?utf-8?B?Mkg3MVQrTFpUbXFsaVVQcDNNNGxoY0F4RnI4dkNNNWFyODExYlVNWDRaOWMv?=
 =?utf-8?B?bGJGMTAwcjUrQ0JDZFJXUWxkUHdHY1BvYUxKZTREa1pzcDg0aVpqeWttQTdn?=
 =?utf-8?B?UU1qSHFFWm9jcFd2OHo2cVVqeGtYNkh3ZlA4cm1BS0dLYUgxbGJ0TGFUVUd3?=
 =?utf-8?Q?M0OwWEdYDy+b3G9i9DtlG0a+N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e36bc0a-4334-4cb3-5a3c-08dbc3676b00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:48:34.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZmCmE3orKoaHRAkYXVrnTXeuiRBuWRI9R/dSTaQ96KAPgj6aITc5HD9j+kX5TxCDHknt0hMwsYIjEboXr+biw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/29/23 16:09, Dan Williams wrote:
> Given that any particular put_device() could be the final put of the
> device, the fact that there are usages of cxlds->dev after
> put_device(cxlds->dev) is a red flag. Drop the reference counting since
> the device is pinned by being registered and will not be unregistered
> without triggering the driver + workqueue to shutdown.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 44a21ab7add5..aa1b3dd9e64c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -152,8 +152,6 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	mutex_lock(&mds->mbox_mutex);
>  	if (cxl_mbox_background_complete(cxlds)) {
>  		mds->security.poll_tmo_secs = 0;
> -		put_device(cxlds->dev);
> -
>  		if (mds->security.sanitize_node)
>  			sysfs_notify_dirent(mds->security.sanitize_node);
>  
> @@ -296,9 +294,6 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
>  			if (mds->security.poll) {
> -				/* hold the device throughout */
> -				get_device(cxlds->dev);
> -
>  				/* give first timeout a second */
>  				timeout = 1;
>  				mds->security.poll_tmo_secs = timeout;
> 
