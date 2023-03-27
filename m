Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460CFC76195
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjC0V5u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0V5t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 17:57:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F012E
        for <linux-cxl@vger.kernel.org>; Mon, 27 Mar 2023 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679954267; x=1711490267;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mJ1WAo/rtYBn6ykLtDX9Rfx7Ausl0RqG+NvAu+Ukcik=;
  b=Ux+x3DmZMohw5LOOB0lq63cf4UlMGw/E5hD/FKKbBmmPneI4XulcK15x
   AzWjbdiysWvR8P1dJWGuVOa6GJLuDlKFwjIr+02Nppx+Rw5azLF969Ai5
   jxe7NK/t3KwxFv4dcUDB3nilu2DBeB44676dUxx+dRAtr6PVzHeyxIDIT
   AWfEzFcTCveKP/1uyH9iT3xjNbB5QZjqXMztajdWP+1dudR1o+8CjITrB
   vchFhyo9HHZOlwDazt398BhwIm2Pgt21Sl582jRB4N7/5DjMFab/3W1Mn
   DnNFojBFZ2MEf91Hc8ly/P0w+briZdO3x6RkQHB0t3xrpn9rt5k05cGJQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324285267"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="324285267"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="716233913"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="716233913"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2023 14:57:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 14:57:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 14:57:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 14:57:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 14:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfwRIBfAcZfvU+wqDWeDYffWPWmfrjubTpIlLIncnHE0RTrx2nmwoy1dlJ143210LhkDkROiQBa7pdZqKMuKW2jhc05IYSSaR8fhqxE3jitzIzuWcfn56O0FS7h25iaaupAHtLM2tw71WwRuFlKXFRq484tiCRa7F6ZVCsdUIMObi3HFFy1+46CzsKA2K6zz7fnEaPK3hqodIlCJubWMWYVWmEAfWIFemz8dXnWNyLchRNoQ/FzRcxmsYayfNnIpXXA0V7rBYsmYqZo+Fr1XoLd1jKMosCxjPnmNuJOZ0OtwC0x6JjzgUL+NwCa+LkZQVEmL4y1Vvx4R3A8m6mp33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKTRopzEycm3ozWBTxqfHNIiJ1UhT2uxRoRryic4sAQ=;
 b=SVTm71MFCauOK6DVXLjEI3XmONQb8bgGdi9okPEVW/T8iNQ2r693qeuvQ9wyPgvnNcWIxlQWFihUnCeyX9E4Pa4n09GscZioJVUh7aWFoBC6M80ZmrumQYnvfZnzDpPfgTWkHj6rLToQzmZ5iaR8ij0SUQ8oQzc4iBZc7DBmvNuQjfX9DhQwF+AEgoDKBU9nljbxiVHKD2vinYM5UgR6+UuCbi8GWjqh5aiToCtFJA867lfLSW68dDKoM4xA74ZQuYWugCBsHlg3ABRJtNONC8SYHaeGa3T70b/aoAoX0hGTIXMSk/72vhPkIdBo6SJT11smUGwtbBy6+Ga5RamZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 21:57:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 21:57:37 +0000
Date:   Mon, 27 Mar 2023 14:57:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>
Subject: RE: [PATCH 1/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <6422114e9b764_21a8294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230224194652.1990604-2-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a23af4-2f8f-4613-b97a-08db2f0e4720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zb59XNEkmSG6ysjE8Su4jYF0FPNSyv5p3AVUC1+bvCtLNhS2Jt1AH7m+70CyE5gXjRBxV6lQbLcgyjmRJTtYjPZlCu27uXLT6ycocDrktlPK9I6Il/nrAOVvY7ml9bpatyk1pU/FivSGUHD3LMvKR2No2Olsw3bpayfazz/ju4x2Sv8nxjPyJVDIZP2sVhc/gPony8MHaGokU5CjS69IgynIqfpcxHlYad/BeMXkqeEhJXRD86oSAgED/KI3Tnjr7DQpyPfEhUhoU5zsGvayeKO9P9IeBdm5Wd45VNby9DTYljybIw7YlqRRhAqU5ZN5KfrfYDle9b6B0ycqED6am4lZDL3W2cmXTkmUkLa3bhgIINnPauGajhtXV+aPWJoRZr6wIudAvzuvG0oppKCIV+5NYYAjBEWL5hOrd+oyqxeINvQYnBjYhxK/epIttYjZ3fuecHbKloL9l8RxoQObBvJQWwc8jJhAPwkt9aDOgp1hkRhJe8GLHeY3DE6gCYQIoXY69n0/KkTo/1ERMzSGDo8wiFeSf4CRj4yv6yh2Td76Sslx6+V8/EHl26zYqL+T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(66556008)(66476007)(8676002)(4326008)(66946007)(316002)(8936002)(5660300002)(30864003)(41300700001)(26005)(82960400001)(186003)(6506007)(83380400001)(6512007)(6666004)(478600001)(6486002)(38100700002)(9686003)(86362001)(2906002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bd5u42KeE6evxum8OPRCJPjI2bqzu/0CJNTtBv72zccorWjyeCT70xAntunL?=
 =?us-ascii?Q?jAVoiG+ddEqAk3XRFIxG6F3aScHMcqrIIxooq4/0OEV/OlS8t85SkrIWj9Ib?=
 =?us-ascii?Q?VqU5ZV1KT1LqD+m9IVF/C6AGORA/8sRwlCNml2dtlwsrkPRZ9uDdrWlukSyr?=
 =?us-ascii?Q?XiSlbdPiNS6bG83g/zjgrhgr4fTjfAp7cDn5Kn0Kwsoyv830V9pWIp4ne86e?=
 =?us-ascii?Q?SVPgGe0ewvUELGXhXFEh/obtf6fb0+WdaE14gEy5xz3zHjPR2LibF42SnG8o?=
 =?us-ascii?Q?r5PbRK0F7EgSFGiHriukiLc/wkwvEtqzx8x2EI6uMVsvXvrjWbZPB/wTIRC7?=
 =?us-ascii?Q?8MuTZt3j+zxBmf7ipLVMkgjEA4SY3AKi1jsMVMWHkuvgX3P6GyOnVphQtMF0?=
 =?us-ascii?Q?irFDcCLsk/TTaUBkpgJMAX/TQCqcPXie8AyOQn/7CvAoz1w23PlkH+BdJVMk?=
 =?us-ascii?Q?KT0FRoml0kU6xWkuj5XuY5OuKs3l7seqB42/p20BvOOFFz2hOQcdbe1bTWR4?=
 =?us-ascii?Q?SEDxm307anlYC+cnG02CseTuhv72lVcCkyNgAQirKdtHCOG/Si01Gv01AZF1?=
 =?us-ascii?Q?/6SIwh7WJcJtTIflimM52z3Vn5M1QmCu/QqAUNwKRnKL+SV0Jlm3Nm6/rdwu?=
 =?us-ascii?Q?xTSSCddfeKPhL2DEGEFPZv35+15toVHz4KRjmIH0UYB3Sl8GVu87BgBz3iVL?=
 =?us-ascii?Q?bUA2KtYkPFnPJmF26S5MG2tGQ98XvuIFY2kIso+plgOzZu2XCARFxnfLGZoB?=
 =?us-ascii?Q?IK3eL017rv0YQiH6VG/OAiCjoP/FlBUMEQXhk95g2Geab8UVRMUArwLeLLub?=
 =?us-ascii?Q?rh5/PXAXKxgbJf631h6BnT7Y1zhxi1dP9NaLMCEcstQiSYN9yIap8HJcVMtP?=
 =?us-ascii?Q?DtlluvVMIfs/gsjHYgyfrBr/2WBqS1YgAl/4Pfp1+L+hrFE4ypuogFDIMUpK?=
 =?us-ascii?Q?7IvQH1T8Mjq7KYFjlJj4bwxoV0p30RzXJet9gDlYVjTCh4aOv5NE4ZEHSO+o?=
 =?us-ascii?Q?Y6hOb6s3AMwe3H+d0S/9SJ4raH36tX8kRbYKSwndlSCqPBAQFfhIqKhuXLie?=
 =?us-ascii?Q?dJTNdONZS7u/bgCq0TKFiXkwrJ9Pyn0E7uJ2IKZM+zHjbisRT4BQ/9ujNGKr?=
 =?us-ascii?Q?wuYBtjtDp+raNBUj0UI/nt24ie9546D9nm7+9hyT+nc3J2XubRY2EFS+ZjXb?=
 =?us-ascii?Q?bIzGDAhfT44jUlMu8lgmLg40B+4AUzII/XoRSKIXwhq6C1sxakOmL0iF8hqr?=
 =?us-ascii?Q?asNDyd93tl6zdATQiWX1W9yMtxHmR1oum4FXvMkejW2mDkKpUuiGKewYeSRo?=
 =?us-ascii?Q?stFxw+IaCIAZSTJ198YAN4WDJaZpOaegyQBNBa20fkx/VmeAn3RKRoiFy925?=
 =?us-ascii?Q?EkA1HPTWE+ZY2+Aa6idYuuIM6Y1A3U0OF4QCrWkqKLJb27QqQ94Um/YTcV9r?=
 =?us-ascii?Q?d9QE+2jJYlR6YdKQ4I1AnynCtm1MO8TAUbwZIxCLND9r4khhwrZHIpu0T5Fa?=
 =?us-ascii?Q?ORg6am3PJll/c3TJJHDwBllJPYfbipuYMJiHY1FZSeG51pKeIVh5HPFs/KKL?=
 =?us-ascii?Q?SQPJ9EyT9V/jMqGZrKaKWpaAkOe5KJEBPzFhXh3ZBvNrRDqZH7BGEMRWrEAd?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a23af4-2f8f-4613-b97a-08db2f0e4720
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 21:57:37.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXoGPwEwG9nTJTkDpxQek1oxTYPnekmXwrvj2O4wuQ9Xz3WoQHGssD8vsTk44Vc7akoTNkaLYr8ucmk38jD1kHTf+YJuZHwLAE4p2Doeeak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:

Hi Davidlohr, I am finally circling back to this, some comments below,
but I think this is looking good.

> This adds support for handling background operations, as defined in
> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> can run in the background asynchronously (to the hardware). Currently
> these are limited to Maintenance, transfer/activate Firmware, Scan
> Media, Sanitize (aka overwrite), and VPPB bind/unbind.
> 
> The driver will deal with such commands synchronously, blocking
> all other incoming commands for a specified period of time, allowing
> time-slicing the command such that the caller can send incremental
> requests to avoid monopolizing the driver/device. This approach
> makes the code simpler, where any out of sync (timeout) between the
> driver and hardware is just disregarded as an invalid state until
> the next successful submission.
> 
> On devices where mbox interrupts are supported, this will still use
> a poller that will wakeup in the specified wait intervals. The irq
> handler will simply awake a blocked cmd, which is also safe vs a
> task that is either waking (timing out) or already awoken.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxl.h    |   7 +++
>  drivers/cxl/cxlmem.h |   6 +++
>  drivers/cxl/pci.c    | 100 +++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 109 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d853a0238ad7..b834e55375e3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -176,14 +176,21 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> +#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
> +#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
>  #define CXLDEV_MBOX_CTRL_OFFSET 0x04
>  #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
> +#define   CXLDEV_MBOX_CTRL_BG_CMD_IRQ BIT(2)
>  #define CXLDEV_MBOX_CMD_OFFSET 0x08
>  #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
>  #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
>  #define CXLDEV_MBOX_STATUS_OFFSET 0x10
> +#define   CXLDEV_MBOX_STATUS_BG_CMD BIT(0)
>  #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
>  /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ccbafc05a636..934076254d52 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -108,6 +108,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   *            variable sized output commands, it tells the exact number of bytes
>   *            written.
>   * @min_out: (input) internal command output payload size validation
> + * @poll_count: (input)  Number of timeouts to attempt.
> + * @poll_interval: (input) Number of ms between mailbox background command
> + *                 polling intervals timeouts.
>   * @return_code: (output) Error code returned from hardware.
>   *
>   * This is the primary mechanism used to send commands to the hardware.
> @@ -123,6 +126,8 @@ struct cxl_mbox_cmd {
>  	size_t size_in;
>  	size_t size_out;
>  	size_t min_out;
> +	int poll_count;
> +	u64 poll_interval;

An int will do, right? This value should likely never be above 1000.

>  	u16 return_code;
>  };
>  
> @@ -322,6 +327,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 60b23624d167..26b6105e2797 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -52,6 +52,8 @@ static unsigned short mbox_ready_timeout = 60;
>  module_param(mbox_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
>  
> +static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
> +
>  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  {
>  	const unsigned long start = jiffies;
> @@ -85,6 +87,25 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>  			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>  
> +static irqreturn_t cxl_mbox_irq(int irq, void *id)
> +{
> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +	wake_up(&mbox_wait);
> +	return IRQ_HANDLED;
> +}
> +
> +static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> +{
> +	u64 bgcmd_status_reg;
> +	u32 pct;
> +
> +	bgcmd_status_reg = readq(cxlds->regs.mbox +
> +				 CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, bgcmd_status_reg);
> +
> +	return pct == 100;
> +}
> +
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @cxlds: The device state to communicate with.
> @@ -178,6 +199,56 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	mbox_cmd->return_code =
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>  
> +	/*
> +	 * Handle the background command in a synchronous manner.
> +	 *
> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> +	 * which we currently hold. Furthermore this also guarantees that
> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
> +	 * in that no new bg operation can occur in between.
> +	 *
> +	 * With the exception of special cases that merit monopolizing the
> +	 * driver/device, bg operations are timesliced in accordance with
> +	 * the nature of the command being sent.
> +	 *
> +	 * In the event of timeout, the mailbox state is indeterminate
> +	 * until the next successful command submission and the driver
> +	 * can get back in sync with the hardware state.
> +	 */
> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> +		u64 bg_status_reg;
> +		const bool timeslice = mbox_cmd->opcode != CXL_MBOX_OP_SANITIZE;

I understand that sanitize is special, but it feels out of place for
this to never give up polling when sanitize is in progress.

Yes, sanitize is a special case because the device is media disabled and
not much else can happen with it. However because of that I expect the
admin thread that submitted it may be different than the thread that
wants to check the status and re-enable the device.

cxl disable-memdev memX
echo 1 > /sys/bus/cxl/devices/memX/security/sanitize
<select()/poll() on /sys/bus/cxl/devices/memX/security/sanitize>
cxl enable-memdev memX

Per the spec other foreground commands can be allowed through while
sanitize is in flight and the device is expected to fail them. With
background commands I think the need to be careful and queue them up to
avoid clobbering the background status goes away with santize. If the
device has sanitize in progress the driver can just reject/fail new
commands with the "Background Operation" effect until it has had a
chance to reap the sanitize result.

> +
> +		dev_dbg(dev, "Mailbox background operation started\n");
> +
> +		while (1) {
> +			if (wait_event_interruptible_timeout(
> +				mbox_wait, cxl_mbox_background_complete(cxlds),
> +				msecs_to_jiffies(mbox_cmd->poll_interval)) > 0)
> +				break;

Given that this does not check for -EINTR what is the rationale for
making the wait interruptible?

> +
> +			if (timeslice && !--mbox_cmd->poll_count)
> +				break;

Per-above all commands that the kernel would synchronously wait for are
always timesliced, and sanitize has special behavior.

> +		}
> +
> +		if (!cxl_mbox_background_complete(cxlds)) {
> +			u64 md_status =
> +				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> +				    "background timeout");
> +			return -ETIMEDOUT;
> +		}
> +
> +		bg_status_reg = readq(cxlds->regs.mbox +
> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +		mbox_cmd->return_code =
> +			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +				  bg_status_reg);
> +
> +		dev_dbg(dev, "Mailbox background operation completed\n");

Might be nice to include the opcode here and the other dev_dbg() above.

> +	}
> +
>  	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>  		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>  			cxl_mbox_cmd_rc2str(mbox_cmd));
> @@ -222,8 +293,11 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
>  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  {
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	unsigned long timeout;
>  	u64 md_status;
> +	int rc, irq;
>  
>  	timeout = jiffies + mbox_ready_timeout * HZ;
>  	do {
> @@ -272,6 +346,24 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>  		cxlds->payload_size);
>  
> +	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ)) {
> +		dev_dbg(dev, "Only Mailbox polling is supported");
> +		return 0;
> +	}
> +
> +	irq = pci_irq_vector(pdev,
> +			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
> +	if (irq < 0)
> +		return irq;
> +
> +	rc = devm_request_irq(dev, irq, cxl_mbox_irq,
> +			      IRQF_SHARED, "mailbox", cxlds);
> +	if (rc)
> +		return rc;
> +
> +	writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> +	       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +
>  	return 0;
>  }
>  
> @@ -757,6 +849,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	rc = cxl_alloc_irq_vectors(pdev);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> @@ -777,10 +873,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_alloc_irq_vectors(pdev);
> -	if (rc)
> -		return rc;
> -

This hunk wants to be its own lead-in patch so it can be bisected
independently of introducing background command support.
