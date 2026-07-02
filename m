Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BD420E90;
	Thu,  2 Jul 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980121; cv=fail; b=hOYQFFT5CbHsjo4gIv5bDNGZnh1z624C7qnIEkShaisiEi4+09Ci1Jn+cQiOyNAlOcXWVvHNdkq4w+rUvTJjasiT4cmO/AbPAYthxg+FBt66YX41NFH+2ABYbCo1p7NhCbQUPdhRYdwJF8XyIJmXJdhgXL1bpsMkZYrKqoinpys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980121; c=relaxed/simple;
	bh=xH6i9XSu72pU+YwRvten7Pw9G45o0bQPJA0ywjnpvAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RIAEhdYHXi5OaOLz74iLc51hmhREOeMcpXRdidloNEroQQ4WPHxOmXpBg5jRTck2JqQnq2puXWjfz8sWLt0YDmHvMx6ZkzLwbSjEbjmSlWTlmq8uNCVF/0cO9L2paumw/NZ2AxCNsHe2H7oEIV/OOf1aC5SoItzgqcvDoops2xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usFZ4ihE; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usFZ4ihE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaLRTLV1djQZX/ujna1faIaqLGnbDTBbbR45xEN1tw6+vL2tZxSExrKxQ6uKjCiFC3m8r311YFS03dXpl/RyUrBFlAxbi2GwiMDyWb2OExuP3t95pk8sie7ft2Ba+VrDzdYUIbipf+Ssu091LgNrgCyeSRKz/FqeHyPUVr67qxoyiXj3wUqr+DwoBKfOQyVMtHKBB2X/op+3o/ZwFq+pDJbPmzOfvNSUWF2yJC+iOTIINbf57HoLMqtU8AfZGD0PAw44iGheEPU1Y3p1xelEdmHgyLehvo2M2Y+xZX+apU5UOV5QTu7L5KqaaretVTDb7ItFjlbNdFQHk0DyUBPlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG776k9avwr+nGxb+8gCRMUgOgOVtshUUka7DM7P9gs=;
 b=k1Yg1A54bVSjvYv/dXZBt1V7M5CViSU0YIMBCSDp9iyL6H0dD8U0t0MiWwVY+j4l6SeSF4xjuN39PW4IiEAjA/sEq9cf7UyDzSvmf5sVRw59CbisrN6e326Qdlt8Roo/SRGriQO9mrnUZjOztoGVY9b3n5YHkzb9mvGgTNmFm44ElHPUjlJPYHQls319tu4f5kEt5LBK4MytXhGczncRzH5XsVtjjvXIcFQhc1qq9oeTBDTO/Ee8obchVRe3tgGqenXiOERlBXHYtRSUCr+wGokzuQ0b4u6Sxzuxoz4tmhzYJuoI8IJLmTK7hbCwp5lcGIoIfyplWlNzBWnGQoj9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG776k9avwr+nGxb+8gCRMUgOgOVtshUUka7DM7P9gs=;
 b=usFZ4ihEh74eb3AUSmwtD/kRbGxTEB0b3aInE8CEfvOIcmdP6FtY7ru6QXhggjj8iUaB8DOpT3ydvJSuuPTYVn5Lnkwz7Ht5pIHds7eV/Decc4Q9YexL/GXyDTzRfpqzrz1Yz1ub6SOOtQHyH91ZB/oZY0lJsDw7xBkE9xfVtWOaHUTszlu22HUAdLzRBxsJJ8VUE5moJ3k+mQl/8klDr738uoB/Eni4YGGTASAxie2DxlpOs/YG7PFUEbR6bkjO9ELbI5vmuDwhzHBX/2UpSf9UHUhV3qxPDePJdJdgDHYuWakKcPCXO6Xv+cO29OyfjMhgk5TW/GOgPv6BM3m1IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 08:15:13 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:15:13 +0000
Date: Thu, 2 Jul 2026 16:15:04 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, 
	mochs@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH 1/3] cxl/features: Reject feature offset that overflows
 16-bit field
Message-ID: <akYddc2XRTz7Jywh@MWDK4CY14F>
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-2-icheng@nvidia.com>
 <3cdc48ca-5c39-42aa-8853-e5e3a7884bbe@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cdc48ca-5c39-42aa-8853-e5e3a7884bbe@intel.com>
X-ClientProxiedBy: KUZPR04CA0026.apcprd04.prod.outlook.com
 (2603:1096:d10:25::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: a281dadd-b543-4665-d456-08ded8120a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	JqjvOIHujkVFRt9KaVR5pl7l8sEheuQ2KSXehEoukstzD/jonmZowGtEHX3ca52jeXh6UDzmckSXsSvjW+SYolvsptoYr4gB4O2RNZN3BmpbiSHoSlSfFgg/tFU9W6sejsmciFj+HUP/c56X9T/myzlCf0WXoKBK4yppHt/odbgJAXFRYCBQyrLHwmMghmi2Shf3DBAY6sZj4UZDWzbUmthSrLtt4uuUA6iYtFRrZmUYvJW7TwPlgX4BxvjTT1V4IbWM5LIzKBdWJTlK/WMs0Vcbc4r/p1j2IQNSXoge3kv2uBsl6QlUYwmKHYFvWWb/POegZGg4eLJfo0iIfhiBFQzQX+h+y00aPuAebhwvy3wUmHD8fONCbj8+O7TH8bWpNYrDLSN9htsvbYTdzCFFjAe7erG4aEfRciK/FQUM65SoAPPRk+pRfRXXvlKnrzAgKKtRYhxJ3M8FsOHXIyFvAYVNSDRPrdiGP7v5hDHwZt4SYLfv4cZDMMhnuwdSaAAhKW/IBgnrljv9khbJr8lgDWYcemXwd6xQFdkOTe34+YjCDI0quL1rTOsgzzzT+X2kJ4Gcavotmm7VnjPy7+WgfSWzpxsXww18xcSuaCJUXMyvSNVLyqDEgnmxEaD1uUQ/gpbuysxAyXlDckuOY9Ouk/B+r5gJ8lkXo7wZGhIXLqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R95w1v/tBH3pOWceS7N03NwzbWqfiaTTHXpSIbYiSrRyJapHt2y0jf4I6p3A?=
 =?us-ascii?Q?Z54QW7DwIMJfaabU7c3tYsNfyPBbgURT89p3P+XmigwELkZFcZw4EpdhUmlx?=
 =?us-ascii?Q?nBnP7zLmRPPn+JHzozo8jvYsRVCG8FxE/xoWESZRwC4VVbQb7DX5IZ+PUrXK?=
 =?us-ascii?Q?iehoo5/rTrul+r4d2qqQLVkvGzOptJg11alEKvSes0zt9upvHKFmBIzaaO0s?=
 =?us-ascii?Q?SuzxeEJn+pAmYP5AoC61T1NS3KrDjuvhFlPNp1Bxt+bsrmGOkiaxk0LuLuyB?=
 =?us-ascii?Q?HZykorAHjc186wZmMGCw5E4+M6tLXsLIS7bGUPVIw/ClcKpIb5qVq35/s6oX?=
 =?us-ascii?Q?OxIlLlM2tRLq3gi+2nJRDQVUyeV343mkTyB129Md/1evFcgywIBdDQXN4Uil?=
 =?us-ascii?Q?3xUKwpg54xPXAAMYsA2AcZjnL56QlO9DADs7vKwnN5EJ+SXR3HzH+as9R2U4?=
 =?us-ascii?Q?2eVTPO+g1ieUbHW59au82DdRZpGnePr+ea/gHillEabGjVwas2GOxUgnewsU?=
 =?us-ascii?Q?bgPUu4OUNeUTNI8tj6eDGHyRz/CzMtlyv7QnlAZnYQ2ReOCj5Zc/QUvmJly9?=
 =?us-ascii?Q?h38CWStoyfaFSo9KxHXCgiUB5YQ9S8Wsm4eq5jEyigpmwQqVi/SYzuHTGsZz?=
 =?us-ascii?Q?f+5MxAhRJMNnnWoUVzvDutg0AmG/KggCdX99TSzIheDUxCd0D0zTclq31ALI?=
 =?us-ascii?Q?rXBC+CWZsoehivU0UtbBWjsdY0joe2nc1jz4RgOEQMxqo0b2atLZNVYgqk+z?=
 =?us-ascii?Q?C1U9jGoqvAHFeJZYiA+d0zK6uA5MCkdbLZL3Qy/qibVfqxvT1QH4oxEguj1m?=
 =?us-ascii?Q?6drjsUq9ZV6+Fj8erWSfHKmSpQDdS7iDkwmTpWDiHu0Bcl1fL0xwOZ+iq/Mt?=
 =?us-ascii?Q?lk1lxKpznEdlLaioflr7q1tU32Zbsr/AghouOFDbV95BRjmY1frm/3KSGvOd?=
 =?us-ascii?Q?qYrQkYIvc4Czm2o4faJ9kuyyTGdzg2Z82UFdb9+jGE91GbUglyI/HvoVBLAl?=
 =?us-ascii?Q?BEuIFBqLW+55O6ofA61eP0i99AdDE02caqNzlnTbg2Vn6wrHm9HXu9LzhyVx?=
 =?us-ascii?Q?j0wWol/w9ShFiHciBwA8JrSSYBfWAVlNN2DAI28q0qkT8Oc3WmtolSROmSwu?=
 =?us-ascii?Q?zEpdp+AELM81RQ+lyt/PT7JcJwCHQMubxxBuKBL7aSe6vepPE8cl1XF+aURv?=
 =?us-ascii?Q?Se6pIA8pNJExBCvZUgYUI3WzS2/xnBYz0O7qHSDyqSLH5RoVsMtCPDG0t6dl?=
 =?us-ascii?Q?GRXZ6OVv2lUO4OFkNdhet8CyQcBFjjYc+njomxgzSetrAWnU745q0QWNrJi4?=
 =?us-ascii?Q?yQm0hIKplX7Y0MDdHn2QIy4SkJLBpTkmXdLYqze8TUYJrBKztJqYGuABIXvB?=
 =?us-ascii?Q?nPvK0KizrCpRqnLn1khSxYJkyXwgnRn6IjD3kRjUzmU+cPus6V8ZjxSKNBo7?=
 =?us-ascii?Q?1YnbgmHITb2YUy9+KPkRK4yCZOjO0WHQEekMRYRqLIFMlWPFK+BqGY5Vjh0N?=
 =?us-ascii?Q?gmEG8D29UJuMlxr72gWntGonXyKNT19WmvCVjRwwBvAoZiPYIWPRY2Bmeok5?=
 =?us-ascii?Q?+LD0uY3TFW0nPokmbBqwYF/lgoXbyhL5Id4h95z9UyPy2FtE/hUxTMBvqV0j?=
 =?us-ascii?Q?yS1O/XqKwzAsncMWsAmKSWrjTyOu0Dvzw6uQyD2ry0PNUCG4F3fI9CmvXXYq?=
 =?us-ascii?Q?II69RnYgGHxLjn+QX6hPReb3QbCcLJcRmOQ0LaQiH2qI5C8a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a281dadd-b543-4665-d456-08ded8120a47
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:15:13.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUqKPctU1HOVxCCAPs3PTHJPmoDfEt/XKAgxP2pDDXEsE3UJ00HvMbR3rmZ1K+xOqS480DCcA0tFTH9yEH5qJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

On Tue, Jun 30, 2026 at 08:54:29AM +0800, Dave Jiang wrote:
> 
> 
> On 6/30/26 12:46 AM, Richard Cheng wrote:
> > cxl_get_feature() and cxl_set_feature() build the mailbox command's
> > offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
> > check the sum fits in the 16-bit field. Via fwctl, a user-supplied
> > offset plus count/op_size summing over 65535 silently wraps, steering
> > the device to the wrong feature offset.
> > 
> > Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> > Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/core/features.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 85185af46b72..db5964ea184f 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >  	if (!feat_out || !feat_out_size)
> >  		return 0;
> >  
> > +	if (offset + feat_out_size > U16_MAX)
> > +		return 0;
> 
> Should this return -EINVAL?
>

I don't think so, the function's signature is size_t cxl_get_feature() , it returns the number
of bytes received from the device, not an errno.
If you really want this we need to change the signature.

But I agree that we shouldn't silently fail here, maybe move the check into cxlctl_get_feature()
and return ERR_PTR(-EINVAL) ? would that work for you ?

Btw, for sashiko-bot's review, I think it stands, I'll send v2 with the fix.

--Richard
 
> > +
> >  	size_out = min(feat_out_size, cxl_mbox->payload_size);
> >  	uuid_copy(&pi.uuid, feat_uuid);
> >  	pi.selection = selection;
> > @@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> >  	if (return_code)
> >  		*return_code = CXL_MBOX_CMD_RC_INPUT;
> >  
> > +	if (offset + feat_data_size > U16_MAX)
> > +		return -EINVAL;
> > +
> >  	struct cxl_mbox_set_feat_in *pi __free(kfree) =
> >  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
> >  	if (!pi)
> 
