Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0C136678
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545243; cv=fail; b=TkSs3dgWChp7QlCb9GYP9Ar5F5aKpkfJHFLusenrOaUTkx0UczWS4Un0T55bJtd5OWJilOGCgWxj/WdtHpsFspHfBa5YALI2Yz0Il07Rb/6iLpTR0OIzfWG3tcrOZCY21WN4/uGsGCoVq1zIvbGDoU/HljhR7f1govEFnctzWMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545243; c=relaxed/simple;
	bh=4D5pX7PjnoFVpvuymbjARDtgFsEcBNLoZm0ihb/gmbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWU1DvJYHn21EBQZ56s/uD3XjFbwtCfhgwxF1GS+dsUOHeqOTlVC402iMh97gF68t6SbQEDF8FsLV6B9YE2YWeRWTmtr1legVPkhvuo0Q3PtLRzZYSMF+Tay54A9ibpgfr5hS+ZCmB4eD05kVDa9eIh6GTs94JRUgmUriyKNSQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=n91ZktXk; arc=fail smtp.client-ip=40.107.244.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="n91ZktXk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/R2REILsxa+Lby3IozQAZX6yt+/js7d1rC/GulBvZ99pfsF//1ojAEZxQE9Qbxn2zn1uHvrHlKwTnB3fq+yVVUGkG+aR35uaB5z/RcRIXZanuOMhPJ7BBL48LeoXCcU3ZASSmm8V3/4ngwwnmZu+g7zj1AVx5fcRIop6LKBaH/lNPvKDzKhzwdUl1XjboxIip2+GXK6LsNwA7LqazASA1OH+oeW16Z0T9V/nuLfhTEysDif8nd06GuIQ0sG7pxD4wYt8JY4wrnvUyHDjO6heB53oC8d/8kEAI83QdjnTbaOpmP/DaNW8H98Ribd9pc7LakJLcxYNAY0GokIPNxong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O5SN/kbcZE1RJvNHgJn1Ew4h0Jp6Tod7OxY2D/H5Qo=;
 b=XwHTwtHcUUcFvUBKQTXSaPbigq9+FS8f0z2vu/h474N+8+DSy0sP+1jXSfeNEX/qiqiH4gKIdpysRbGKPk12ZV2qstBB+ACaxU2FZieFso9wcufXP1Xj+IMGsrhddQKtPQrftayRlmF8A44H0j4W8GfgOPThzXgtw3MPFFRjAhdCQ3PueX/545ElU+HwNuGUnn6hMKC3drDbYF4/SrW7QY1H9SVnZ3rg56ighIOw8s+vT0TZUZ7I3k5DfSZeW4PcSGKPKJCBZInDHvJat3CAnyuHjwCaEiYXZSbYQ9pydQx/QYyV2XGEEy6qU6FRauszvLGCr2yq3NYdgQ5rUQv9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O5SN/kbcZE1RJvNHgJn1Ew4h0Jp6Tod7OxY2D/H5Qo=;
 b=n91ZktXkfEMCWishyFQn4WJBCoryuKYwkJrZgA7dzV0kvT5+4Opv+1YwPQHauF2c9TD6X4png39CKPd6KAWLCK58m5gnqO7OVIia93kFO/JbbYo8bd+4E0XwMXZZlkbmbAGFZ38zr2vYnWq8e8DcufGsyNeyHANmaBf9ZaHsQKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5742.namprd17.prod.outlook.com (2603:10b6:510:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 16:47:19 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:47:19 +0000
Date: Fri, 19 Apr 2024 12:47:15 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 04/12] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <ZiKgE0nVEiS8WEOY@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-5-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-5-fan.ni@samsung.com>
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8374bf-e173-4b7e-c4c5-08dc6090606f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Apyzf3+jO17on0r7kWW6CQD9rFhH/NF8JktbSZGgCxEKNYm7Yd+nAnn/f+TY31Jl9hHr/82pSs17Lmgd7IlVGzlVikAXHeNmLgsbYH0WH6Uu3z1dZVm8nWchwGG0l08gBk2xqulEXKxI1Ft8BLeZAYGnFd/BiEebdsm1nPEmk+U/sU2kLwElET8whESQ2SgnLHF30IlUIZDxqs5PZ589dRMAZGEysXLfGYBH1k9snQtyYKi8PwheKS7+ghAy/FYNNnyKm9nHpGUQ64sBrN5F+NgUXNqIl9aL9SHBXGcK6ovYiOkhXmP5KFgT8kTff07WQTa9O/8OU4rUuvO9Vc2Tv2/FpDZguJ2Du0ZDoANg8dJqghGonYjRC14CRjJ6qzfj7oUmER4vGNv0ViqIpis10e9ZDmi2oZVeiBC/hmXnvxZHfFfrF6/SYf7ULF9xsbrpooucVMKgO/ckY15frL1E59e++0GuOj/HiWeIWnR9WwjUtjqzb3UGsJn/sAbqDlWToIZxA3VR+A6SYJkUNsJdMfcknnWxV+yE6+0AC68/fEoH5n1JXLPEwpsR/k3NdplQJ39kUy05uwGR9520jPcfknCZE0uv0DNqlfYvgKWgxjEWuKMq03Lf+kRvCqoiiS6vGFFOtUM0pjLp4n8RShEw9gc1RtJ/+8kVcPW36E9K3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZCkN6xbBcnVqxf/B+7f+uJHOXyIzJqhhHdDme5vVWwOvYYhOJjajJZFEmQE3?=
 =?us-ascii?Q?P38goQynRn5w1FdxqlIlkwP/Fa+ZItb0yh3/P76nDVmk1CJ+9LeumYjroR/S?=
 =?us-ascii?Q?llKJYXkagSKnPf9gRY5QWtLCAmeiY7TzeFKsZMhODfef4oItLdAZ9zuIhYd4?=
 =?us-ascii?Q?Z1fQ3/dIhzrkSrFog2xfKu+DA8mxr3IMJoCJPBngmrLk+V88dXh6SY6Y2epP?=
 =?us-ascii?Q?b6QQYg02ps35s6m/1rwyKjqBd3yMTqUQpDilxaPoAmf7n6NbVAf9Ib7k2Kel?=
 =?us-ascii?Q?YiIX/Fy6sa+7Nvdc+3ErMhagu/o0AjoAohGHINXbe4EDIQ2xkT3jFN0tnINf?=
 =?us-ascii?Q?58UDxnUWM1FewQL+bBGEqILi2fX6LLrw9td3h5aQUCQP/z3EGDGRV0lMWYmT?=
 =?us-ascii?Q?fU2aUptr80gDycsCWYA+kuiBhNwmPpdbDEXsUBrIEPdOuiaHzPmQno6quRyg?=
 =?us-ascii?Q?Dp761AAY5LGHUA331YVhKUvheFo35UQBb9ZJbujBNTvqH7QQCjDgJ1Z01T1l?=
 =?us-ascii?Q?tLZJc9BmPh9otZOq0vKN8qWb9KYEaASgm/rOzyNBzPNDaR6MX4u4oPXZtelz?=
 =?us-ascii?Q?GYE4x9CluHTi8psGvO82+z9zOaZ5cHJQnh+E75Dyx/Zr4QhZ271IWeIG0XpP?=
 =?us-ascii?Q?qCXY+TAQnfQeVsuqWau871zcK1GNJeZnPCUNqSeX4LCQWoq49FARIJ1lfiIM?=
 =?us-ascii?Q?IJWdzOm9tnTjPb93z/ATHziXyJX3LrgIdQvJxcZjVbLCiUBZESXGk7g15CPs?=
 =?us-ascii?Q?a7W94eaDUvqcSqQrHyeFVQiSsrHL0p5OR2XbdofKOea5ipuj5E3MVF2indUk?=
 =?us-ascii?Q?pF8KJEMapezBByUXyFYELRxYF9257ascrpt0er5aiB9g6oc+JtldTDgwY69f?=
 =?us-ascii?Q?XGZ5FsWH7OdeOkqQnLlAJl+TYmATpnCpWJX3VZW4+5O78PpxwlG4mN6OzQe9?=
 =?us-ascii?Q?hsApOs1bGDwPrUECVwW37flcxEguew6PTFWxLrdyqi+dLv9LJcdvt7oQojVG?=
 =?us-ascii?Q?K5BWBTFW9TYfrPXzB1T7b1/oXnSXV+SUFtBIN+9414T2Obpu6c6+heLmdVfv?=
 =?us-ascii?Q?CwSGevG+7av0apuv3vSrfAZ8IlxufpAE3h9Y8LIGxkRdD7h3GflSQPGh4iTl?=
 =?us-ascii?Q?Ohbdv/Su4nrbukr+IEsHJzrJwDI8svRZJbLNe9CTQ7dGYgUQe6T5EuyvtWWW?=
 =?us-ascii?Q?Z2+y/iXT3iBstTbVjN5fgwblIhKpNtcs5wML8Mh73oGKKpvIIrBpFUQaPq9R?=
 =?us-ascii?Q?HZlkStvQeQcKlRvz/kbTtUMmvxDgicYDPRFRbFp3b8ugSpNO9M1vTixwXtAA?=
 =?us-ascii?Q?+JlZIICKgR8Q5c/fAM4TYFpuyN9ssEXW1KvTKazwqMMBp5laB7iHfidUNpfv?=
 =?us-ascii?Q?uSz1faVYclTu64JNYMyXd517hpos0BHZwY/2YdvFvmn7WUWMdiRb/isvxO7+?=
 =?us-ascii?Q?GTPzyof+A28rMYpcE7gStvQ4o+qlwwmg7bpAwP5cTe3Jaj1UhoWlOqUlG7pY?=
 =?us-ascii?Q?8Pq4EqXVFBWU9Q3dKMeKhP85C2f+AtNUVxTcyS0VLTyeOIDDOYVE/lgXGthc?=
 =?us-ascii?Q?TX98/zx9Vm1ecV85UJMixkAlckof1dnFQKLu4h807zG/md7cwIYq9qlDjo6r?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8374bf-e173-4b7e-c4c5-08dc6090606f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:47:19.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XRVbw0mATq0yw7Akcbm0O2UUb8Pg90dylnoRVTaSLf/bVtaL5NLeDCn4eLp1lSJ+PMo0qS8pYear9MesYoGiRD9SXEGz1BE+6rB0OmFgkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5742

On Thu, Apr 18, 2024 at 04:10:55PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, when setting up memory for type3 memory device, we can
> create DC regions.
> A property 'num-dc-regions' is added to ct3_props to allow users to pass the
> number of DC regions to create. To make it easier, other region parameters
> like region base, length, and block size are hard coded. If needed,
> these parameters can be added easily.
> 
> With the change, we can create DC regions with proper kernel side
> support like below:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region > /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
> echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> 
> echo 0x40000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>
