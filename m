Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186C3D9DC5;
	Fri, 28 Aug 2026 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906299; cv=fail; b=UWT85OwE/2updj/Rb3j2iUPkFD5OjXLc1oVQAkqrDdWARCdvXv4/h4eUi2OZsvJbMFbjhKK6FgZfxAOfxoXkcyZtoHjh0140elgaOIa0ZpwbkdSpSeBoHtF7uQL62KH69uCLhuKY0kKftz6PMTMt5powRndp2g/EmCXZ4UYoWEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906299; c=relaxed/simple;
	bh=B+tS7e7zl5YUPSe69lSuDk6kKHfWOnb2flZ0sXq5d6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BczWdj3sT+J6E1RBkLMCeetPciKCa14s8a+3JyG0Oq0+/JLNug/ysepPQNPGLqUg0ftfQIoYaGoCW9MGRu8ECg+Z42FQMXIL9ahF9rpDNz2gIPgkRBBWDU22u1wLGiGVjJn/WdjirXH9Fg7ZioouHDo2M9iIRe3Ik6i91ZZyQMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+dh7tgF; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+dh7tgF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5+cgFs30io0usrSZLOf0bdZCkyzWnf7wPoK3cUh7k2qeK6AdcHYDPPU3DhwSqKyvz/KIrHgpnQyy0Wk4Wje9mDKgT0HMAAnMXdQtl4cDZ2ELTt/TPnMmvxcB3L2+B9KYYXtV8VfEypTBkEpkfmZJwLyBPPMLCLrZ8WMngN53o2BpwKBWC4rk86Hel5rA5rSM3n2HeKgzRnjGU0NyXBUTJfr+PjfMF4ehk67+lQJiLmDx1nbbaqskRrtXxpWOzJW8ZDX0gHnHMIfeGAUsqzle2y4hqLF0JS3LpKGkGkB8OOjk0XSupnTRLiixZKUANQGR/cilRvjkneqAt3m24rvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALWKty5wfrxu03s4zVhauzKA8dS0XoNs1EMPoczstpM=;
 b=Y0LSuBlos0iODBP0mbKdfd6WnUYGIZEkmbP791Im9697DF2KcFg2bGbAXDRjXmVD80eBbXOEtG7RbZqJ4LfDS2Jjc3yPj/3is3I8foxPagXugOj3MfeeeMoC3pg8knZW0KZp0UfFaMGkiw1svW9fXkF1NLfT9mMd82KKmojc1kvwndxw86+UfN7nV0xCyybdSq55jLrF2WmAkcv78uVihgEjJrNwzS0X2/5fIiv3bMAiTo6dRthdJevC0+zIAUmdKzxLcAdZSPA79cWeWKQk9sDZ4QTSiRsLB3cfg9BhphtuJsDvsnj4Pd6kVK2qHzb/FZFVmu7f+pc3i8lxbX6YLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALWKty5wfrxu03s4zVhauzKA8dS0XoNs1EMPoczstpM=;
 b=L+dh7tgFIfJoC1Bk2fxlQtsjMDokfgwGbwe0d5Pb5VewiCEYot0/WKGD/S0iuN1eEXZr2JKjpmmkh2gfLPs4+SlaVh9WxYszgAvzAVmJ3ZfDQf4KwE+Rn21QRblcx0CBQRzvOg0Dsi0bS4l0oXvK/6A9fYGjn1LfRP8kFh0suMonD7KWihpwdio60hDljlisg605gLZUgSNeo57YM2Sxh4ssfQAC99qIsKSZFO6DDz7m4zAn0e7wECDxnUf80ScLTJcPzajRZZqBv/BqYnF8zuolcsBvdD0kDyREK9sPDTsgTdRi44CZ4SZjYgm1WWK8nzJrysSWqCofCbiqIpSrLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:38:13 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Fri, 28 Aug 2026
 08:38:13 +0000
Date: Fri, 28 Aug 2026 16:38:07 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net, 
	rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com
Subject: Re: [PATCH v6 7/7] cxl/fwctl: Propagate feature RPC delivery errors
Message-ID: <apFIzMv83ZpPm6MJ@MWDK4CY14F>
References: <20260826014508.9989-1-icheng@nvidia.com>
 <20260826014508.9989-8-icheng@nvidia.com>
 <e3447007-4bc7-46f5-9bd5-f59b84d6113e@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3447007-4bc7-46f5-9bd5-f59b84d6113e@intel.com>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 8449ae29-a65b-4a77-7590-08df04dfb2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AVxiYJS6km2aMYLirdyWIu1zQx5RmygC5l+x2hXWgiIgqzE1bdpAZ1QI0I9PwrhvqQPWMcDTmQXoS3FhotuxG251dZeHNRtWocX8xzg1QO2ntnRO5+JZQ2L2FpFdef1FRbHOzeSpbd0jAY9sLq9EnDcinFE4oRtaWIowBRtEne06Irjk3/iIxao5f8HSrQmU0Ecwjudie2XNXEAP0PR2vTkZu/egnpikxvl8G3ou83SZnXKsdA5ITtC0P0xAa93hknKIXBevuQu5Z9jyUNyUwUML2a19LDxl7hnhBhmROrBZP11gjuhp5p9FlhUjBz7NGG7vS1h3js/X5HTGTIk2cKFdVOSxzmO4FQDtw/xAGRHkUPL3kDyftpHepHmlgNxWOoyTYAvWAXa8byTEG7dYkWi7mG+JDFeyCg/i+OA4YAtiY1u6ywTJ7kaGJVZh+MMErnzAnpcFa4N9cW4RYN+tNlCakw2qTmCXMhnpymHjn8Przvuy5ExkyfhdWphU6SuvLqXF+cmGfmWd1XBu5IF1UGfcKvR8FzqOEOBvk25YnsmTnd6ySW+6BVbITsfjVLC3w1o742wP77e/p9zBYugRlep+zzKXxK5QfS2H/ZvySPJ3dAhk0Re6rEOHW6Q+IvSn4+qwaYo+llMK/frYwYptNoY2gr2aYrqYFKpExV5F5CU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZkJ4e69d9FizPQUcBE/ammChE5RuG+YhTBQP/juiW7/ZtIbUY0N/cOVctt6c?=
 =?us-ascii?Q?KYaIVZgOSwevh4BjSyFP0xBWfa6EO5k3EXEiK9Pzlb4VxXBlM8rIqsM8Vb/G?=
 =?us-ascii?Q?Pnl+TpKAo27IpaUYc6zvy9QbH8nk0CuLK6cNANvy4cNlf6IyTNqEhX26JRk/?=
 =?us-ascii?Q?wetWarRHNXcvYILdZsREksy4q/qKFjAHQXCKjsjtx8ZQe4sBsM6NuYL319jY?=
 =?us-ascii?Q?9jrcNuC2PgOOM8fBXkO2684x0tKqDnXU+3Y49c4v//kZRKfk27xzUu9S8JWc?=
 =?us-ascii?Q?xO2my7278Ixesn4NBJ2NqeZMDSGCTkeny2LY6wdue3MeZ2XvQ4LO5Zs2/7vH?=
 =?us-ascii?Q?5OnwcW/0uKovLH15boWVaAA/4I5q+dQiHsbjzaJ60muBRcgnp/+5opk52FU9?=
 =?us-ascii?Q?dPh4C3j2G/IUG5OkO2rCr/CAHn8fuUDNFTSrKoViCFRYsOZzebb2ro8GHBPi?=
 =?us-ascii?Q?USnfs3qwvORoGxcfGYP9Q2NtsSo3b75mpH9budpE7XJHyZloERWRgsO1JlA5?=
 =?us-ascii?Q?OsrvhqlWchKnejDnhQZImuFqg+pPehbi1wW/e2hVDXgKAktQ8DBC6/WSQpTi?=
 =?us-ascii?Q?toKUFMu4BJ/A+90mXu3xe+4Vxknl+f0i85JkUhg+obd+hWAMnPTGt24w6SH5?=
 =?us-ascii?Q?DpdRf3+a+qxZX1PUhO+8yJwLQ0+iaKcEjC1L6p5Jm3v0JoB0z69v6nOJny3S?=
 =?us-ascii?Q?hZQggOs2AvEsG7r1gvjbjfEJ0AhzBAiwf6Mj4UFQpGwhFFGV+sIUCc4Dm5mV?=
 =?us-ascii?Q?EZckA1H4oBDQVe68ufJYQwTKn2zA9Bd2XuEEcUnSsHWD53q/xY4I2oNcp7X5?=
 =?us-ascii?Q?+kJaPUFe7PNJjmgL1jm2XEHMWlqemUZ2mXd4zg3pQ9OVUmff3hIYtMiahuY3?=
 =?us-ascii?Q?tsBycC4vYK/tfo6gZeFtx9yP2g00SUZJbzzd7Dgh6n/Be/hZfdYXZMCJAeRd?=
 =?us-ascii?Q?1hSKxOi4dzcbbLScE8WBKwQ5qD4E0ejwsfNb/uD4oAtdJ6Dc5JJt3IdVF7cI?=
 =?us-ascii?Q?ogCB9D0wdR5/Oe/VqdaH5B2XHpt5pZQl6blK0V0X2WjGl0q7nn5YLqak/0rL?=
 =?us-ascii?Q?JdirSGrifARYUiMQxbWmBIAokxmU0vWg6fQkrihEmWv9R+LbqfmkYQkulYha?=
 =?us-ascii?Q?4jAAaN1J03LQjuLAWuxL0nahgmvjBblhktyT/3WMqD07TvWuYwoQrhoCENz0?=
 =?us-ascii?Q?Zm5fHrvlcMOYU7g4HK2HmugP/XTdh/mFwHRHBXtw4mPwqbc5q2oGpsMkbuwY?=
 =?us-ascii?Q?aaGxXo5cBHZhgv82j9D/AvBeMKTQxtMvK69AbBWC4tr/DHZHobHy5daAb0Z6?=
 =?us-ascii?Q?KW0PA+3j/tkH1B8RsAjQevvckMqO40KVuJ4ZsFuX2dM4Fwe99jMs88J1jW8d?=
 =?us-ascii?Q?/VpXnd9EZ9bJKUziPnpT2xqwRWP386adstzvNND/kl0AzGcOONZOUsz+rqiK?=
 =?us-ascii?Q?wLSi9oEIt1msytqRRi/lEzJlV2aHltvgD8H7Y4rNiDKFfN+Ft/NV7Ttc6iNt?=
 =?us-ascii?Q?9rgukUsqNHaz4ytw8pcalfFDPLYWSBPHSWwHUzsAhQcGmk2rJWnGEGWb0JEG?=
 =?us-ascii?Q?scsgokIF8jemzqBDHhbYbOv24WYntlFw9OhkLog5lca5oNQUa3HGD4a8CYnz?=
 =?us-ascii?Q?DvXpGghNknIO2ki6SLUiEyLmGLps1XWibyyvJN+oT6zGokv5jyK5088Cki28?=
 =?us-ascii?Q?iCedaOuc8yhjQ2A18NPW6BUxwmYBfTzAY0ZzXHpATgwZSAR1GFutMb1smxim?=
 =?us-ascii?Q?jHAQNIJ60A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8449ae29-a65b-4a77-7590-08df04dfb2c2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:38:13.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++wUkzykRk4zZFmmavIo6tflJ6lcOJSbxv5LswDEVzgOchlJzuwGWWltK9Eh/lxs0qJQQ4NhWEA0TSRxEbxVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

On Thu, Aug 27, 2026 at 03:11:09PM +0800, Dave Jiang wrote:
> 
> 
> On 8/25/26 6:45 PM, Richard Cheng wrote:
> > FWCTL_RPC requires delivery failures to be returned as ioctl errors,
> > while device errors are reported in the output. Get and Set Feature
> > instead converted all failures into normal responses, sometimes with a
> > SUCCESS device status.
> > 
> > Initialize the return code to SUCCESS. When the helper fails without a
> > device error code, return its errno. Continue reporting actual device
> > errors through rpc_out->retval.
> > 
> > Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> > Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> > Changelog:
> > 
> > v1 -> v2:
> > 	- Remove redundant CXL_MBOX_CMD_RC_SUCCESS assignments. (Dave Jiang)
> > 
> > ---
> >  drivers/cxl/core/features.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 8d44ce829497..28b326df3398 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >  	int rc;
> >  
> >  	if (return_code)
> > -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> > +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> >  
> >  	if (!feat_out || !feat_out_size)
> >  		return -EINVAL;
> > @@ -267,9 +267,6 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >  		data_rcvd_size += mbox_cmd.size_out;
> >  	} while (data_rcvd_size < feat_out_size);
> >  
> > -	if (return_code)
> > -		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> > -
> >  	return data_rcvd_size;
> >  }
> >  
> > @@ -289,7 +286,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> >  	size_t hdr_size;
> >  
> >  	if (return_code)
> > -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> > +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> >  
> >  	if (feat_data_size > U16_MAX - offset)
> >  		return -EINVAL;
> > @@ -341,8 +338,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> >  
> >  		data_sent_size += data_in_size;
> >  		if (data_sent_size >= feat_data_size) {
> > -			if (return_code)
> > -				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> >  			return 0;
> >  		}
> 
> Minor. the {} can now go.
>

Ahh sure, thanks, I'll remove it in v7.

Best regards,
Richard Cheng.

 
> >  
> > @@ -492,6 +487,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> >  	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> >  				    feat_in->selection, rpc_out->payload,
> >  				    count, offset, &return_code);
> > +	if (data_size < 0 &&
> 
> Do we need to handle the 'data_size == 0' case here?
> 
> > +	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
> > +		return ERR_PTR(data_size);
> >  	*out_len = sizeof(struct fwctl_rpc_cxl_out);
> >  	if (data_size <= 0) {
> >  		rpc_out->size = 0;
> > @@ -544,6 +542,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
> >  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
> >  			     feat_in->version, feat_in->feat_data,
> >  			     data_size, flags, offset, &return_code);
> > +	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
> > +		return ERR_PTR(rc);
> >  	*out_len = sizeof(*rpc_out);
> >  	if (rc) {
> >  		rpc_out->retval = return_code;
> 
> 
> We may also need to add something like this because of the change of default return code. The code segment is similar to cxl_xfer_log().
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 28b326df3398..2e62f3720072 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -259,6 +259,17 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>                         .min_out = data_to_rd_size,
>                 };
>                 rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +               /*
> +                * Per CXL r4.0 8.2.10.6.2, when Offset + Count runs past the
> +                * end of the Feature the device returns only the bytes up to
> +                * the Feature size. cxl_internal_send_cmd() reports that as
> +                * -EIO with a short payload, so stop and return what arrived.
> +                */
> +               if (rc == -EIO && mbox_cmd.size_out &&
> +                   mbox_cmd.size_out < data_to_rd_size) {
> +                       data_rcvd_size += mbox_cmd.size_out;
> +                       break;
> +               }
>                 if (rc < 0 || !mbox_cmd.size_out) {
>                         if (return_code)
>                                 *return_code = mbox_cmd.return_code;
