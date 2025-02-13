Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1D206F17
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472219; cv=fail; b=PHJJ/NSwvKlQKkMegi8ATrp7sm+Frwn/06XqFZTNS8TiGpIn8DyhwJjY2cY1BM6mwqBklpJ8ACTpsC8pC+6BsSKHhTC2leV59CDA7MOrlUm2TdDSZfFHCOd5SyljzzSWNYckLameOG0pVQ9FwdM7dSfQHSmo1gWvE84VOzAAE1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472219; c=relaxed/simple;
	bh=vbiCb/8SX27HFBUUzjVwr2WDLEo0Te6lFh/z0t4aRqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gD8vnziuj9RQdAeBVxVU9OkuvgVvfoeRuN4Jkd55wDkJ9GEwuZGTa6P/CTA/WYyXU40W102Dps88p5W3yvb+fDKvtLYh5ZUXq3N5s10gemUFnx5GmxSevvpx+bGSrc59pqtuKMnJV8GLNttpZJzMF2j0im8Ym50XSwIO6Xk2X1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lHBziCKU; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lHBziCKU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQVqDx/pRCyNPcC8Zy5f5EKMcJ+Z1UoEodM45WWrJd31dwdoHU9SUmDMsRnluRkDVEGXbXsKSYaWiOUPNjfPegf8V6ps4i+D6P4eLNd6mlHwYCCNyFFbsvtbBZMRVaBu8mZky2neqkZ4IqaXdTwpQEmGjelWbzFj2uY4K/IvV9SODDwz3C16GszZbB5+XjXAf77vXdSUQqK5dJMPJIeCkBp1RD3q8TvZMBeEPh3UVJvBnxumQOqKirEnpWgyBixUrYF9bQQcBoklMCINV1kh+Nxpya5j8pfdy8DHJSOIkACcR7aXMtyy/VgWYypJRLFu4sO95fZt7OI4NREqKdNImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqTOvbyvkKY3QNoUOUITfdjkQ+gbuutF4OegsAIgDe8=;
 b=tV+NQDBDWWnB2FFzX9UAfGsg+7aEDS3JfPZRU5DVniv3jBkgbR7VDfguSQ42GfjJDTS2dlqWzkOo+Uf/B/b5YvxRundsQDVRSkAqQKHE8BSgpjpQJry00UJkoKUFMO144Efx6f4/k0SSlafYp9BPJVmx8tRqNE6RlvAlRkvbDIL6DW+90PeLSLbH+YXFgfIHSrpGIMkR4K74WYqbyh3xj8orXKtUSFvzHasYpI9DumzzGSnmRcJ2wbxMS5MuVvkzxQnVNxVckNEdyTuRhyy9c1qinJwpXYBRgRkEI6Fw8BmnjhYIpEhpM0Z+sigPpY3QlDhW4gjC6/CMyimxFWY3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqTOvbyvkKY3QNoUOUITfdjkQ+gbuutF4OegsAIgDe8=;
 b=lHBziCKUusFZ3mpEH4zSNIqydnz2xzBVXm0u/+U3WCkKhbyJttkZDtFdU9Qab/0DdN+RActLSjr1ReWrFvbeEOdE6jhcCCL8ZXNkeTRtqPsW70SDYxILMW+ZPI1GsYI1BeeO/tcx0bbUf/zGKtk+Y7KNBI0iOSgcaog03KkS2oXd+AwEVue8xI5te9RdkLgpQeu5kC+zID2YZzHQlpo5WjrJXIKPHAcCF8RdYpsEW01q7rhdU16h3ZfNqcwWh3VEmFl5pkQhoYrpejOTcE6YZ5XxPX1rYJjGhBf1pGlcPQsALdoTe49/TCp1pkd16bWuNI/HBHDTTENEZKmFZkMmMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:43:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:43:33 +0000
Date: Thu, 13 Feb 2025 14:43:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	shiju.jose@huawei.com, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <20250213184331.GC3886819@nvidia.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com>
 <Z60QCS6o-3VInenG@x130>
 <20250213153200.GE3754072@nvidia.com>
 <67ae3b12d24a3_2d1e2949a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ae3b12d24a3_2d1e2949a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BLAPR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:208:329::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 933341a7-e6ef-4704-1c8a-08dd4c5e5120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PT6aAiichOzeG44xOeh73MH4UprcJa7hrwUeXe+Z8yTzhqtkbl8zJxlCdJz6?=
 =?us-ascii?Q?VAr3tHJyYM6jWcWiXEFkCQICJW7GY4GXsT5ObDAZFeqUCiXWu3r3Okz9CG0D?=
 =?us-ascii?Q?1OgNszYC9veu67SkYbZquMVni/+Moe7mFZTY94Lbhd2t9YdsaOjp97gNtB9i?=
 =?us-ascii?Q?LTIv+4HDRC2PNlkFguxQARdqCHWTy5/8qE38TwNvxF1cghCep4YEi6Ke8VTj?=
 =?us-ascii?Q?HJy5/vJRlL0XrdOInK1M/t2MW+Ro/tNr28tgLX99WL35jpp2NoYgpnyB46U9?=
 =?us-ascii?Q?xOCy7/LKNij/i8Q+SoQWp4ZRZAPy2/f7dxPZDV0bFtQCXGV47jvFKUgbwogQ?=
 =?us-ascii?Q?SS3RpLX6c05aKrgpYmQgc0fc/SOB9ieJjUUMyb4Q5sAveYnOr5O0M52CaduW?=
 =?us-ascii?Q?IUbCicNFs/7lMbnWVhNjrXxhSQ3SEpsUXAwiXRvvamWUVJEcYv0ojLI26GPO?=
 =?us-ascii?Q?lDd0Uwe2x3Y3oQ24IYZC8cU93Y3VCzOkWW6RZkouahLNCCrQ/SqVmKv5iat5?=
 =?us-ascii?Q?Jby1/RVUx+eWqNMT5lIcLYsXuQAK35cefCHA19Gp0Ynf6S5XJSrwikPxcXrQ?=
 =?us-ascii?Q?NqJEuTc1uIE1HPwsA+EIPuIqbo7rzplu5rBORd/T0tlWJTmly77WODF8aNEK?=
 =?us-ascii?Q?JqVMNHWmJ7TBJDQYqXVcwFQIC9lYKxPNIA+lYc/dykZC1Gc+4l2ZAVHe/n0C?=
 =?us-ascii?Q?BZhRyfwOo3NP3c7+ZEgGYKTHK/k+tskJY4wCyfm2pP5m/7r0gO78TbVUooBa?=
 =?us-ascii?Q?noE2YTZAGr05xpl9SAdG6/Azr2Os9IsHF434euCtSyUzb1JsFVMzGQ9JEsj/?=
 =?us-ascii?Q?zaGiT9dEPZTLNpPxy7nrehS9jB9kPDUCHXv0rTQ3DU+Q2Jp/ae7jmtJYTHfn?=
 =?us-ascii?Q?di2r1nSoEWINsDAtoBOCPkNXZzvJ/4IqybOWBdjPcsrq4sITP9YAVnxmjWNz?=
 =?us-ascii?Q?1W3yNS/ZuOUIL+9+wukcK13Ul6BDRvVxniO7Eu+WjcfpEhKbXkTIrzJijtiA?=
 =?us-ascii?Q?0bVNPgGY1Yn4+g1oruOvPclBesRBSdL2VycaYOCcjBgHoBZeUM7jQbd+QIsq?=
 =?us-ascii?Q?qY7ZDqJjIisGXKnrkisBlzTIFvlqSgkU246QCkzdsqwtaUVN7zdt4Yq7zsxH?=
 =?us-ascii?Q?/oG0W8GXLu4LrU6dl85kLc6vy3yFF/2lfoO220zNX5kXbwHUvHxgtsMhUw21?=
 =?us-ascii?Q?Kr8/6LDDQcMYICm5dQlc8mL/opp/FEO4kF03CtSwR1ZPNrcMCg9ZdBJ/z+hq?=
 =?us-ascii?Q?a0xaQAks0ivcfstX/ibE+S9/CcKuXj8vJVKGhgQMGWtF99Gx2Ge0DalQxr+I?=
 =?us-ascii?Q?kUDq0ydNWIyhNDD4wStAXVSlfCzmxGY2wr4528UUJuYJ3tLLr0Ae5jtJRgXW?=
 =?us-ascii?Q?A+fstF1NTrO8VuHISeHDxPPmd1Z1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x5fHRT9ntC2cENTkOW52XrNbu19WOxaLxwL/riQxu1/NsaU2iLtI/oPmESsz?=
 =?us-ascii?Q?jRo8qwsGS3NGPwpJhtpCZsFdnu6PlGRcZH3gO6zWYHjo8gosBFdthooEkIhZ?=
 =?us-ascii?Q?vtjE+wcqggoKD10ZTNNDalnd2DqJgSR8VCF9kgu4ijKGQj/SOaogOhZ2EwXL?=
 =?us-ascii?Q?jGK1K+0f7W8MnDbCF1TZE7AYRVmsNQNr7pLN6RysN4xXw4Y2ybrUNgWBX/Pp?=
 =?us-ascii?Q?HeCpsYKCSe3cuXmb//SHYU+rK6e6oomBWeoU7rtxe/7Q4HEk6aBYc430t+i4?=
 =?us-ascii?Q?n2O9QjEUePAeM+oO7goZtGqEtrd39n4Ejm4l1pA5rz77Yi5urUx6wk5M9LJh?=
 =?us-ascii?Q?XFRe4PUjZxCtYRmKNK79lKcOVIOcfwr4V/0/tqdJAZQEwOJJZbChTwG1D6rR?=
 =?us-ascii?Q?wHg/jg69bjSlIJw5L41yrmkjHknvJiusbcYgNldzYrgwBjtM/i0/YxjNnrQ7?=
 =?us-ascii?Q?+l+4GAW6iJiKw360hqlTiOa1NPxWhdZwUontcknDXuB5p+1i4oU/azGfEwiB?=
 =?us-ascii?Q?8P/dnEk2Dnd6XAOB2sQNcDp92Pc3B2L2oEIt9c9aqkHht+e9+5pjJRjfnwgt?=
 =?us-ascii?Q?f67M0m7nRzIdodI2O3pBx0A/0Pno0Iay9i6OjvvqrqLpsdNwDMgxMHsEH65x?=
 =?us-ascii?Q?1qUUriOFspPy+8C3fBlm74CEaYTbi7Hb7TO1ZeuNbaXXeM55w05yBaxceDWf?=
 =?us-ascii?Q?Y8n61sd4BQWI5UapVlKhexVWsoZ1xCdnBOWUo2DonKF2JTIw4JssSKwH4eMC?=
 =?us-ascii?Q?uJHjAHz4Vd89+XzmzBhjWB+dqnjzfY9+XadsmTzbOLa3rV9zDemwK3DMRXG4?=
 =?us-ascii?Q?tBMzniHdvg14nufnMqFPiOxoGfwXs3sX029DP2t8DORTXR6AAC8W5BK6FyVa?=
 =?us-ascii?Q?zNCANa/K+rwo8P/uiA5DxObSSa/11obb6mxwC1GbNRGj/i1qv0mJz69Mxu9p?=
 =?us-ascii?Q?fPEDsjG4RUhOfCrOZsEe08WhC+PxrGdysQeCtZE2S+Hs7fxYp+/AkZ4nYdcn?=
 =?us-ascii?Q?RT11qUMc11jZ9G7y38MOZDvcXdwPEjXz1EWzRhH7Q27CCQslPDiE2s5TTBwo?=
 =?us-ascii?Q?+5JGoWtmCFypjJ2QyDjTLAOHpo9pt1Pw481LU0dPHcfnhfG8jZgT0dYfw57K?=
 =?us-ascii?Q?1lg9iYAX4dkuhfa9HzZD45mwVFywrsY9ebc9wEWLGjPUY2V0G1wuSHwrQ7e4?=
 =?us-ascii?Q?UvRit7W/OIvZx8bUOayQ5tzmt+fcECxDVJgf4F3DwZnlGfHF/S+kI9OXwLdP?=
 =?us-ascii?Q?oFaMSHoAjL6iHyXw+NLW7JcssLHAyIu0P3QhuNW94xoAivhGKqFj9V3669zw?=
 =?us-ascii?Q?KDODxarmnqmUthnXbzMrq1/1fRo1WxAyYI8K//OzXr6M9KkuPaYMwDizykQ6?=
 =?us-ascii?Q?7rPl+Pj4SW+lR/FHl6dBcrXNhwKrqIdNkayW9na6T3I48xbe5Xsv/Sg1k1Lu?=
 =?us-ascii?Q?LttxtUpEl5dIFY2TEgiV+hDDPbct1Peh563xfVa7K38FDlCgD/46+ulxqmsv?=
 =?us-ascii?Q?YGEGCn3cfavrlMj9eZaJbdtTKSpx/MX1Degp1vasNQA1BNQ7P/aOD9IkM+Lf?=
 =?us-ascii?Q?NxXF/HkelaW4nQZaMen2FhR3rLVVhNcShAy6ennm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933341a7-e6ef-4704-1c8a-08dd4c5e5120
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:43:33.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dAm0ADps0iLrg5G3rH2cjGorDpXvj8WtA+vwvwxQsH/TYu9LPEd4R+SxECBk25z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

On Thu, Feb 13, 2025 at 10:33:54AM -0800, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Wed, Feb 12, 2025 at 01:18:01PM -0800, Saeed Mahameed wrote:
> > > > +/**
> > > > + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> > > > + * @reserved: zero
> > > > + */
> > > > +struct fwctl_info_cxl {
> > > > +	__u32 reserved;
> > > > +};
> > > 
> > > I would add some useful info such as: num_user_features, mbox->feature_cap,
> > > etc ...
> > > 
> > > Maybe if the callback is not implemented by the fwctl driver, then fwctl
> > > subsystem should make sure to return a default info struct or some zero
> > > response buffer.
> > 
> > Yes, lets not implement an empty struct. The core should permit a
> > driver to nop this
> > 
> > Should I add this?
> > 
> > @@ -62,7 +62,11 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
> >         if (cmd->flags)
> >                 return -EOPNOTSUPP;
> >  
> > -       if (cmd->device_data_len) {
> > +       if (!fwctl->ops->info && cmd->device_data_len) {
> > +               if (clear_user(u64_to_user_ptr(cmd->out_device_data),
> > +                              cmd->device_data_len))
> > +                       return -EFAULT;
> > +       } else if (cmd->device_data_len) {
> >                 void *driver_info __free(kfree) =
> >                         fwctl->ops->info(ucmd->uctx, &driver_info_len);
> >                 if (IS_ERR(driver_info))
> 
> Yes, please. Let's not force the ABI to be chatty if documentation can
> alleviate the need for an 'info' command.

Done

Jason
