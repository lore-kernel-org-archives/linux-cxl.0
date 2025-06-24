Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB382E11CA;
	Tue, 24 Jun 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778243; cv=fail; b=iiDQMKkdbdmEc/jNZaouppodMwTTUfMdkKGHgqogtRCMBMW0I02PhGuZqJwmwsb9DOkrwEsObYrtmk6TSPiNNOPADTr0gfVAsbOEJ/1CYwc2EV7eVsSgZ7IXqKFkXPqQqlZPbjJFJ9LX4isX0i6EvqY21velJoF/fA3kx3JjA9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778243; c=relaxed/simple;
	bh=x9nLCosW5AkVY+xfpstvOyU8PCPjA67orblDghNCEYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HwJGhB+5sEnqPUsn/9CXiaX9tZAkpoajk5ONJn84MRf62jsIyngNqIrQ5rcfEZreZzYNSl56q1yhFL6o1CYEmp6C3673Dwoes4PY83WZalEOdsLq7fUBrq5ig3a75tDITj7NJD3XhAHsOic+G/JuD5w+aU/xd3ZtErlbTjKGA3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lhuiIkKo; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lhuiIkKo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByYcKU86kMroYexs6HZL9t7TOrOxJ6mHAuoHGJzxhvwS/7Xeq3TNycqflIDapZtzwaqt2ollWCvqrZS6i+NmUs1i7f4YWWlMD4hvtQiv8gIesCiqO2d7WEFtlyfsF0QJaTFeK99a9LRhF0Fyp7Z0tz2Gu9Zbc8p3gGmPI74HKCOAHPetyJjn0TutTBgdpRm/G7JrJWOiDOmmKtkIf9dfXKju9EVLz0wBevR8rP/8J8nPLDVJLe+kusfV0j1Ti/fbk4agnNYjZkfULjE87WROkWqQuLfXcVVvq+/ZgMtTgoINDtckZlrWeqXvNg4AeZP29UQj4zWqlRM9XHpPw5caAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+PFsGQjbq+PB4QX4SEjgGfOhQQjBUxDZt3V0qqISCQ=;
 b=Z1b0sx/aZ4DHBwqhYwCmMjzbwXPjZjAqjoo6JK9/JR9S2no3hPQN9xL7eB9B1vam7+4v9s1XflJWWWV1Ra4tX3weP6UY1Kkls1MLIq01BSMO8aLgjRc6lEYA71+ILbf9/JikQwCuckJWgtOcPa4GeTdQ9mbjbTFETPQ0RIlzzkgz8kqUE7jEl/GJ2MWzmHkKt0ryjO+gYbjLAsQ+V7JbQPbRfNsoOqnVdiGTRPnealjJVo0pdc76JCqjd0l3536VcjKHzWEoCoqffdmzqjhDLX7TGlyYr+FPP0wE0WSL23R/rm6ouBYIV4L5cS2iOd6edWffNiezSUTBPHgFDmrO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+PFsGQjbq+PB4QX4SEjgGfOhQQjBUxDZt3V0qqISCQ=;
 b=lhuiIkKoChk+RDl9sexncioFu+FAXzC9mHZkn/QuBkZ/bWA9eO5bjRLb3QaTwTAW64rTP0/jmWJ/3jN0f2T0yuKTXE8slGbYJc1CWY4BTkHM4C7NV793QAZ4ZO+yjF+9yPn897u/AROYW9NV8WSiUTlBZM9qSPIEIFREm1gkZfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 15:17:18 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 15:17:18 +0000
Date: Tue, 24 Jun 2025 17:17:12 +0200
From: Robert Richter <rrichter@amd.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.li@zohomail.com, peterz@infradead.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] cxl/memdev: automate cleanup with __free()
Message-ID: <aFrBeCn-j_AB1yzv@rric.localdomain>
References: <20250623083841.364002-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623083841.364002-1-pranav.tyagi03@gmail.com>
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 46190a11-93b2-433a-3cdc-08ddb3323592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u6bwVc3F7FokzwEyRzctAWxFM0vJ9D9MUI50xQi+UAiS5XF8l4Iw2m/LobTA?=
 =?us-ascii?Q?uKqN4C2FsB1AmKnZ/OzQB8XKO44MB94bg7+1Q3toucn2Q2ZcsGPieUNn66vM?=
 =?us-ascii?Q?iyB8qlGSMkqMlGssulkVcEhAaLjXrsebfpvvfCxk6tq5poMV+XMeTJ6s4Prz?=
 =?us-ascii?Q?JglP/Hj1t7YWiT8Gy3x8gBa+qOFmzI2qaOjOr3T9xKthkgRI5kOI02ySxbKE?=
 =?us-ascii?Q?rseXQqWWtF7YmEzFWiRXyubfes6OUpPxlj1qG4vjDZthzsl6edrIQvtgB+hn?=
 =?us-ascii?Q?Uhoc2d0zTZlBYehZhXCGc9FV0lsWHvczhqMArRoN7msn1DIsU9g3LPBxzNaX?=
 =?us-ascii?Q?1ZdKhOS9wXoSZ/lwejc1ODppwJZpKKWRUGaqMLVK2AeiOb6xnI2eWMZsnrSn?=
 =?us-ascii?Q?MXjQ4Cuj8HgFqGJpTnlc2dvSeY+xN4lf3c2W3PvQRofSdp/nkWljHyqbaIgM?=
 =?us-ascii?Q?gVxTx92BGqCjDdJouIDD7mZp4BzQ0cLdz6N59mbWmT1nCBLpCzvFF8N6PEpa?=
 =?us-ascii?Q?sPD1nYHEPw13sbz5cH4BgWg9hwL60bgW6q8S2vn33FQq9pHMW/Ct8XDuJt1d?=
 =?us-ascii?Q?pQ+7XxfbddZt6uz1UUWGR4LSS4bwX1m6ZPoHK3d8sWGzQMIe4VPf+oihIUlP?=
 =?us-ascii?Q?QDeX1uEW482sjzoRS4Ik1I5Kuhr/xzmHqabcJLKuhvaSEjxTAATP4KNGzuBf?=
 =?us-ascii?Q?h931qOnD8eSHlPlaFWGuxi6m+ZaTmmnW79I9iwCUELpGOBaA8PyxyRQuxbjh?=
 =?us-ascii?Q?3c4cQSm6BSbXcizoam2lFJDuVb/kvClwqUTq37kzRr+Ie17WoyohoingM9o+?=
 =?us-ascii?Q?7UUfMPZp9HX9OaY583kHjHhUX87wcXtbp9i7U9WEXWsXSt+gFGB6S+JszgOU?=
 =?us-ascii?Q?L0WcTCGBzPkMBazw7P195UuCb92vtTkH2kYaIhEOZKTs15NvIDPdl13LxJzP?=
 =?us-ascii?Q?KNx1DkuiunUoIW5MrMw3SrbhXdm+KiK6u7rhL/5ihkSQ1Fg+IE8EuSyQUcvF?=
 =?us-ascii?Q?DqvXG1ywRdmGhlYsdo+iJSIC9U0ywgYlYe5KF4tHkIs/He5TzEsMHwpqTdwq?=
 =?us-ascii?Q?j4YzqlMko0GC1lgT4TA6bNUyQlMLHZ5PyivlcC485UhdSHw5ubYo8IzBYeOY?=
 =?us-ascii?Q?h3hMat8ieMcDaRiaN4hi2UCZrXDoIiWqaNR7oxn8PkL+dZecye3bXYPsUP5P?=
 =?us-ascii?Q?W6ZCYCOdJ8cyMmtTC0A0p2UJKLF6qskEXE1r0tF610mM1BBUIrKhlPpHXVwY?=
 =?us-ascii?Q?vuFXptwcorJYQntPHmp6w2w/Ijps5xKKzXmX9Y8d3vE3zSpZf8x/iVb5X5cU?=
 =?us-ascii?Q?LJO3fvW3MV8+9+aFJpevvAeJWt2YIdLEcHgZZwigb88jbo+/VZwTprmjuNyG?=
 =?us-ascii?Q?5K2xXSqw9Yz8lak0kvFKSDAz1druptJ4MfQ8Ci01MzHwXM4NLH01ecg9o53y?=
 =?us-ascii?Q?zmMyvrvAk70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gBLmzO+TtzX9F7b8wDweeZsIujm868SZ3GUwTPsGqB2VJWBDpbf9qcPWuPbQ?=
 =?us-ascii?Q?NXp21SFGL5KnwywYkYm1vcfsX673kWXw97G4tL3bPa4kT4mmDFJMoukqwNsz?=
 =?us-ascii?Q?QViIFp9/PSBdEhqLMzEHpwzIIllBRS3gR7d9+6ySMFWdCJ89RwQCS4IZcxuy?=
 =?us-ascii?Q?+CUZ0LRbhc+sY5SDPR5WPl1OB6ERid5R9tVEtZYLwOCQmCM3UdRQbXtt+DRs?=
 =?us-ascii?Q?R025nrGVyQpZW7Rm4cGxhYDIsD3+lEYHtd34gQAr7JKjR26Z3Zu5hxnpprt0?=
 =?us-ascii?Q?sYA/syI2jx9o/7Aj4mZn/kKAIIf6S0UF68CDy0VCGLzarI7tttwsNYoGO9Xh?=
 =?us-ascii?Q?qU3L1IjE9jjEnNtejY7OoR+c84V7uwi2ZecJqPoWJOTbs1O4fhvEqImtVQ6O?=
 =?us-ascii?Q?ed0w2Cxng41MUGtIpLfgyPg5dfcni/HezRdryAMZxOaWSEIbNc+KWYcKme35?=
 =?us-ascii?Q?ypwKVmdBrZzQVP2UJTqxnNEtDQseO0NgpnqP3TDKEG4Y8HPgLZXI/J6q7saC?=
 =?us-ascii?Q?E/ialG1ouk+qK/nekBLs4uOkx2zBQvTTMvCgKMXOrTZvJlUmn4gT+biGp5W8?=
 =?us-ascii?Q?3Rj1FTMQauCtxyJuf92nWf2OZoi3jibHZqh7TDGYtYq03/F8rXV3R+3+8j66?=
 =?us-ascii?Q?jMQAqztejJ4EQyJjjxzc/MBVKEzXMC0o+NaTffrwy1obPIytgKCcGt2aZmme?=
 =?us-ascii?Q?SQ2qkOwrq9ha/erLgfFddCu+ndX91/BV499JjgZy9k0uBzo27+cWOYRVnkmu?=
 =?us-ascii?Q?shJnlLNBOjQVDFf5zV7QO71WeWKzK7mVxZ+0JfT1je9ka5f083Nyg4DMQ/B1?=
 =?us-ascii?Q?kv6wCg6mAklFonNie8AwVUS9D9uAmINZPlLtT9YmmcdvpkFtwwzS9isgEBds?=
 =?us-ascii?Q?eiU2cQUMlOjSCoU9yR4JzqbKVUYGG0Guowss7W4/Zha6t0j542gPf5hXIOds?=
 =?us-ascii?Q?K9Vtx03yctxvfqVP2afxjRsCoFYNDJHadCCuVFkkiZkpVpD3dxFbCFRIeVZ/?=
 =?us-ascii?Q?L7gFXUQYpz33yZf8KgmLz3NTmQl7a+QzeVpU5SGMmqThTFmtpj/V1nnudr3O?=
 =?us-ascii?Q?OXQz5AUTokWnRDSqlnBhBQRt8gwPq0lR2EdCDZG4UvUGqsSZGhZh/J01EvE5?=
 =?us-ascii?Q?1LkdxGJZzMPLu1ekeKmhtl4qJgdR+Tyh1dyPiJVcJhWlqdd/yW8QOlax4Eb8?=
 =?us-ascii?Q?lenff0kAOaRqCqZ99AcqcqR7zxL1OLoVaRPEZ10nE8BKiTQyALk28AnTHDbT?=
 =?us-ascii?Q?gHghoAS15kIuHsojm5Jpi3yPn6idG/MkWct+PW/p0VZOGEpS+eHhGQjgOvj5?=
 =?us-ascii?Q?gmZRkBP+IKbXCqbAM7ODg6C6IouF05gZ3B5nvMcvsIU9g0UugJdabH10JDKG?=
 =?us-ascii?Q?9l4bkJxNx+UMfbzya1gA1rw76jStuse6m/5pHblbfYeanS+Hx/iGtvV/e8Tw?=
 =?us-ascii?Q?xQr1bTtbumBFnk0BDHvuS0iRZj6aRA0Q/hvWewdazGGnaW3BO19bb7o3vz/N?=
 =?us-ascii?Q?lha2/JiyttBRLmLrzyG0JPI6BaqdlmwadxzJeLkSdHrpe4FAmeXH8NwqGT7B?=
 =?us-ascii?Q?rwm9Otnb90DviuixqE52XUWb25XJthjn8cJ59m9n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46190a11-93b2-433a-3cdc-08ddb3323592
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:17:18.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tno2l3IVNKe5RnfOJm3JVF6nPhZ93KBU1euuSxXJevLe69Wm7gZJCljIukS+lrqdX94TBt45aVLI9MhFB1g8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616

On 23.06.25 14:08:41, Pranav Tyagi wrote:
> Use the scope based resource management (defined in linux/cleanup.h) to
> automate the lifetime control of struct cxl_mbox_transfer_fw. This
> eliminates explicit kfree() calls and makes the code more robust and
> maintainable in presence of early returns.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  drivers/cxl/core/memdev.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f88a13adf7fa..38f4449f9740 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> +#include <linux/cleanup.h>
>  #include <cxlmem.h>
>  #include "trace.h"
>  #include "core.h"
> @@ -802,11 +803,10 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>  static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> -	struct cxl_mbox_transfer_fw *transfer;
>  	struct cxl_mbox_cmd mbox_cmd;
> -	int rc;
> -
> -	transfer = kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
> +	
> +	struct cxl_mbox_transfer_fw *transfer __free(kfree) =
> +		kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);

I don't see a reason for __free() here as there are no early exits.

>  	if (!transfer)
>  		return -ENOMEM;
>  
> @@ -821,9 +821,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  
>  	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
>  
> -	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> -	kfree(transfer);
> -	return rc;
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static void cxl_fw_cleanup(struct fw_upload *fwl)
> @@ -880,7 +878,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_transfer_fw *transfer __free(kfree);

Jonathan already catched this.

>  	struct cxl_mbox_cmd mbox_cmd;
>  	u32 cur_size, remaining;
>  	size_t size_in;
> @@ -949,7 +947,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		rc = FW_UPLOAD_ERR_RW_ERROR;
> -		goto out_free;
> +		return rc;

If you want to remove the goto here, just free transfer right after
calling cxl_internal_send_cmd(). It is no longer used then.

I only want those cleanup helpers where they are actually useful and
do not just add complexity.

Thanks,

-Robert

>  	}
>  
>  	*written = cur_size;
> @@ -963,14 +961,11 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  			dev_err(&cxlmd->dev, "Error activating firmware: %d\n",
>  				rc);
>  			rc = FW_UPLOAD_ERR_HW_ERROR;
> -			goto out_free;
> +			return rc;
>  		}
>  	}
>  
>  	rc = FW_UPLOAD_ERR_NONE;
> -
> -out_free:
> -	kfree(transfer);
>  	return rc;
>  }
>  
> -- 
> 2.49.0
> 
