Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F2195;
	Thu,  9 Jan 2025 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424024; cv=fail; b=qyR2mZ/h06JNIR/OnFdS8czb8hWoar1w2ApqY2q+nE+Im9GvR42OvNJBFp+/HcMHCpBkt97bbG4fCk6Ka3N9LXBxRqiuQ8Ih9IJOxFd5v+YJWkr7Xe2Jnud1moBLJ/y5pUB0LZ4SbTsK7xeIN2SHw40QoxB9aam+Dxs0ODzzjt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424024; c=relaxed/simple;
	bh=HEsnsYwA/4VSAzxxB4yi8rynSbVmzExiLlw6ovcX47c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VP9uAX6BcvZTE48h9gYzNy0Mb6hGD+m8usn663IFTYBP9AjH4EKk7qbjxksXEicF+b6V6MvKmYE4eqaVHm58AqGJhPf/N8wFDvm+iGY+FDpaX1IRktkedfDC8sP9Rfy4DgFEes36L5OZqMssah5YtdUHipt2t79U3I4AJrqxuoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hsh5Vnti; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hsh5Vnti"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywR8INcOuCPqMdwFcSXtXjSzHrSGmEfo19TmNbPkFQvQ5uJOWhVISxCuVz36h/EtTYKX1bA+Ey2a8pWktCMeI2RjHz1SzyTAkVXUWGgPQBT3k2UC+yBrfTpCa0PDjdUDyuOzJc4Gy6zROG6gDDAwzwTK/RuySt52Z9pL6rGLwfHZOClc3MSuzOxl803+SEqqPNK0QKMUZSXj1ZVH2HNG1tbjD6uTz0VfISAp1ZcG38nF45v0V2U5xaj1x8Ze/Sl0jI4W0LkqVJy7FbSBkH4ZYODT7hF5J/XDhey3YJS7/VYM7+muru4ppVJgl/zwB/75aj4hnh06MHZYLQ97M5SJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Lf2eQ8j8uR9/K3R2fQPuof/cCds/FqssD0P+HmIohM=;
 b=Eoro3Hahw+vfsJWWWYXYZ99/KbsAg3SbeBIBjx9FTC7l4D+uQsqexCCXoiExv039s3oYR+vuRtPNMPF3RUqX5hoWpE062oI3JdHt9B/6chSkf8qmS0MFRplrM/Tg5ViOWg237QyuWftiqv4Zca+FCXWN4pABw94UYlZC+UxnaK1CkOEo1Ov784Mg4qeVLxjB5wLgVED/zmSL5JrZW7DHQqhqz1YDsRayAi0aWbvPr3tafqh0w7WvCGwuIdo8PxzgFRvsaSXpLJKuAZbqDrOnsBjnCiZeIAmollpqUdHEFo/LwG//bMTPjIOuW5E93/nsavcncA/Y4ThtvSX81lffDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Lf2eQ8j8uR9/K3R2fQPuof/cCds/FqssD0P+HmIohM=;
 b=hsh5Vntix/4l14DCjTXMKoIqXy/PAo9iceeqe3f25tkW42Fq5KbKh92Ltm19YNt/lehhpyjquICPo2b4CkUugdp+6QXnsQA15J66tD6B7dkSISW7WFx/gNB0FqSC9raPHObb0ZhuE2IhVOuDdCuqG0SXU9uLwonvl8EQYFOoZpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 12:00:19 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 12:00:19 +0000
Date: Thu, 9 Jan 2025 13:00:12 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 01/29] cxl: Remove else after return
Message-ID: <Z3-6TOdyN_crspSh@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-2-rrichter@amd.com>
 <d31c9a2d-d650-4b7b-9ec4-2347db07bbdb@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31c9a2d-d650-4b7b-9ec4-2347db07bbdb@intel.com>
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e2bcd3-91bc-45c1-1843-08dd30a53023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BH5A64XAYmer2hZvfW3+vHQEGCBMf8DHqMt+Rs67CzCp8MFNhkSD+pHivSAE?=
 =?us-ascii?Q?MOTnoxSOYbtRRVXyGQlxJpP93bH6t2fBMkHcSJT/jk1MGP5IhSyLGab5Zmkn?=
 =?us-ascii?Q?2RMHtsUoOq+pK4UhZg0RPhaAyKQVazYFM2IKFxsKNL9BjNEJexeDd7jqyvad?=
 =?us-ascii?Q?KNpmRaiUMkuWBLnphQX1Gpbnnj3s/9pemdOgVYW6BC0d/e7m+FQhfANS+pxx?=
 =?us-ascii?Q?+CVkKnK7B5NDRtFShu9hfeqnloPU3vhv0lp+NgfgJNxY3zGjdujinKGHFmeg?=
 =?us-ascii?Q?2PzizpkkxKLha7ZnlEI3fs/k8DFwQYhDLlDviVsYEfg2jRTeVDDT9TD09fGD?=
 =?us-ascii?Q?CdZDrr+Jhuc1WS5U2vo6taf43yGKIyfU6T1aOXgAlpyKo708LsxU+zPcxqAn?=
 =?us-ascii?Q?TUU74GHjauwzujBOaYuMtrc06dVlCxIGztZZxT0U0SzddKAhEQJffHyzj1Oh?=
 =?us-ascii?Q?f4RBBVQFfNHmeqRx1pcrDpI9pXEDbp9qdfolhtC88dMY3Imcd6qderSnF/a7?=
 =?us-ascii?Q?KVdaUXXcrW7Tozv7HQVIMz/8N1yXV2lrSDTGxnEEewooDPB/+C5S71ivAXA2?=
 =?us-ascii?Q?RJ7kTQDX4G9Nm5xSAfbHVOMdnOAuEnFsNtMFX1J8U0KWAPjEPG0SzhbMPpu6?=
 =?us-ascii?Q?SQjEJ74XffWsImbbiFLud1VMrspG6+rKnVzn6SUmkN9lmUxP8lpXZBkI6oAO?=
 =?us-ascii?Q?BsOaoAxoFynKbi/hbgFYknfzBtVmq79VO1HjwPB9cR4vgajnJlLTfEvt4s8A?=
 =?us-ascii?Q?AaLWCWC4js722apKpMG3bUK7eHniyVMglOX2WfwtiyMo7lTd0E0MdmxQ/ZgX?=
 =?us-ascii?Q?2bCaUVhnKoyHlVctcIh8/SQq/Br5YqMzxRDnyu4EpT1rVh6MidX9a7k1us8F?=
 =?us-ascii?Q?CkhYOH8c4g/CjggSssFcTCm/xyez2sPjpGirlHmhxE1KKGKNVFps6F3UzEwc?=
 =?us-ascii?Q?LPGyTYP6oUlL4MZ48Iao5+FJSotG+YaX6O4zhJalZPJs3ElShvN1mmK+SfJg?=
 =?us-ascii?Q?Ynp5M7ZBhR8PaqGjpUtz6K7Kx+ZQzH4xxa9gEP6c6EjXvQqaLJxNZh9HSLs1?=
 =?us-ascii?Q?Dv9EIOeU3dd2FUHJlF4mPNzl8uiCdIRUNxObg09T8gaSkeTkMK7MGu/4snFH?=
 =?us-ascii?Q?RkUpMLOmK+h353SmOk6ELOUPk3sTe9C9/x+gf2Mt2ShyhOfckG6NGVXbEIcC?=
 =?us-ascii?Q?weZALc3o2O/C6CJuXuTY9G+7+rGJtmd6fQBSGRWNyfMMuvPfQH9csKocHO8J?=
 =?us-ascii?Q?dmdmWDboNTsjFIM+ytzDrZQpAhvJ5+7XnqOsFGLMJr3GTUN4wTuQEhri5PuA?=
 =?us-ascii?Q?yuHDDqQL0X4oBsjfFtAKZrWuTsIXaKmK/DEvWhlQ8OIs7gmg0LGJyaYoeMHy?=
 =?us-ascii?Q?ctq4AuI0cjitFhBxEtazytwLtcD2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J3pL/EtQojyRLsd/yYXooGfifjcFO5fvrSCgtW8fLrXVn+9xE927UQsnrmRv?=
 =?us-ascii?Q?YriZTnGhYLq9igrqMegfhSlCfdK6Xlt0idFvxlNWm0KkKdXANs/bmCXtxYKB?=
 =?us-ascii?Q?tETU0hm5r/h1Bt7ZubqZX3fQw1hTGeCiv79CcCQggkpkpiDW3V7JYKQ4pGaM?=
 =?us-ascii?Q?d1KLcEtfG6xkfBkfKR5ufBLIcwNkUC2PCWjAw8keige6ygZbKESW6ik4KCk7?=
 =?us-ascii?Q?f8YbprnaqhDgLPHTb+n2TCuId3DPoitUz6aWaQJj0P6WTCnwzoGLgszRDfyd?=
 =?us-ascii?Q?C3r4/Uebd2iiG7PAESP9lVxCo6zfV70D8qLbw8b1G/IpyDxkMbjwHzXFX0lz?=
 =?us-ascii?Q?HobmbDg7tBhLwyVg7BbfM3l88/cIh3IeqzplsXwg5WyhVhxUOZlbUyuPftSC?=
 =?us-ascii?Q?sDWVQuKHbJbSCDBIl4FIItLOIFs9KuF2yWFHk1w15l+06kJk3RVB/wV2VjDi?=
 =?us-ascii?Q?udT/EckH+qiiFt9IqLgOk1SYV8TkbZDLDIr5TNckLE7nVc352W2Zq+HlskdN?=
 =?us-ascii?Q?zhm4fSrhS+4PNk5CCH0a+RSISe+yTtn+JPJqUIz/KmytaVnFawlENSUcN95e?=
 =?us-ascii?Q?TZuIQDGES9nB/Hs2IHoSdqmAVQkuodOqVNL0AgRRBk2L4H/X5V6kJ2JE2XgV?=
 =?us-ascii?Q?14N5kKn4rIeWivzQAsq0Ux6hVCLT2pH7iHdlrSuvRbBYTak0Hwus7WOE6Hl+?=
 =?us-ascii?Q?ozUQ9EFkVylkfwNzeMdybU1t6v9KNETYLBNDWlp/3/nCemBgMe6a6Mim4OM7?=
 =?us-ascii?Q?W2fO73/cqe1xfTeaZM8pX75S+hcViIiVtJ1Zj/ujjMKo862kts9CP2/SJ/xK?=
 =?us-ascii?Q?DALGJTOhyryO8DtMmN3taajX01/qMkkOEymnFmHPZs7ea8SxxR4lZ7IO2iMZ?=
 =?us-ascii?Q?2kc9YP1wQ8GTKdB5oSdXFg9imLvhHoURNqleEI5+PelaG23TnkKqx4kcV+Vn?=
 =?us-ascii?Q?51a4SHez9a/cXuWX8XXZ3uvVbVwNTxwNvEM07/mIgrVZ5fm8WZgFseS2bp9U?=
 =?us-ascii?Q?rW7dQJtNnufsvZ7Fwl9/m70inZHV4dQxIDObLKiXqUxxq0AHSXHLdtnYip2B?=
 =?us-ascii?Q?+MbtyjwJ38L9W1ZMuLpXRJ4aQamxMBKUEYu3OQKYR/j0TbF0GO6WT3m+Co4L?=
 =?us-ascii?Q?1XNRPr3ZJUEQn61UX3Fiv7hdZmosMbwM0eWZjS8KAdkn/odVGmv83C6CTLeh?=
 =?us-ascii?Q?j9bYxjehdyoFmmljWX7fFn6B87reFAPiNQA3VO89pC0ekWdHxjVctPns+Sq5?=
 =?us-ascii?Q?yIFH6+svuXSwMzBrv4I90yDZOQmmzHBGYOCM1LrIpLRI2fGpZHVGn+k1EzQY?=
 =?us-ascii?Q?7u/+wS2uAYsRCP5IrqLWudBXYGqADwcurwqhiCsSWo1ZNRxCaOEBhtNBjxqQ?=
 =?us-ascii?Q?7q4ulXC8UohjM03Zj7mG//melJy+hbMeMsJv183C4hkT7Kzh0NEvwVB/m1PG?=
 =?us-ascii?Q?zTh3jzbEBep9Wb2uFMRPSsTRwwIKDTGzhw4qSEbl+qGOWsYzeA82FBNpF+lH?=
 =?us-ascii?Q?HgRZC6l6Uk71Y8/vzKUcIlEC3CTvz9vstSDIATEXglrZT3MmYih71abNX9Np?=
 =?us-ascii?Q?/qSawKu0WJYr2j8GCbXzyiW9EO5VNsIlRvM+uSk9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e2bcd3-91bc-45c1-1843-08dd30a53023
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 12:00:19.3370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3Xdjckirwyo9+p4xyvxgQl70fMfDhB4jK9qN4Jc/yBayZuG3FLOT+KRMHHN07S5830xzpwsG6ok4YsO60FiEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

On 07.01.25 09:37:43, Dave Jiang wrote:
> 
> 
> On 1/7/25 7:09 AM, Robert Richter wrote:
> > Remove unnecessary 'else' after return. Improves readability of code.
> > It is easier to place comments. Check and fix all occurrences under
> > drivers/cxl/.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Just send this ahead of the series to reduce this series size. It's trivial enough I can probably take it for 5.13 merge window.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I realized patches #1 to #4 are independent of the rest of the series
so removing it from the series and sending it separately.

Thanks for review,

-Robert
