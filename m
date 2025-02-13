Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFF26B098
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460726; cv=fail; b=Ctl4gbYEX+RMO5fylh+AiDxIAAq7ackKw7kqN4v4vOJnpKja/gm3cZAyRYu+OJSlV04HTbypZ9n9PqeZu6k2y+N/oiXwa8EdBeHtUWbllq8EJxB4hm4TUSUwo+YJ9ptzvk2AAQh3IT/XsfxiGI/O+UwA27jnSvbE8LMm97dR0+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460726; c=relaxed/simple;
	bh=aRi8XKjIrKYWm/kufhTx4/H5cWDq6OlGiEbgxwZzxG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H85ikd2k+GEOo5/0Zm2faf3EL4B82HzqxiVRjDGUPqr7ukRFaw3eWW/SOxG4OIcvh1BVlPNjx0ZGZiIEGejyrIkoxijDdFBZIpaNQbRCcld9jXzwJvmp0+XfBOk4pyLxwva+uNOlKAmpxdAQrFSMH1vauv18SMSh4qqnUuUWbsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kzOeSHsv; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kzOeSHsv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3DnQiYiUP67nmIx4s3kXtdfmQw5YBzTRNMQ9JQsW+FisV4MEesBk5aWUyZqmPLBBxBpmgKKhDiRhblDzUSbsHOMPQpKMT3/kRMoL7M6zskA405E6/hlV1ixkfOUBnqCbQftf9LWPTvvvFyY6MOoHiOni9qPKUSnINdyUqwo+dTeHMr/l7dUbSn1uiUdTxc9fAIJDJEGxRa3ReDelPnmpHK4fTp1YB/3rX4b1xYKuZFvFX7SzHVsfLNkU8D8DMBmF6jnd1otgYoalpaJIZVeZZ6Cf6w0RbuYJbmGuCNd+8El1bEPQpT5vFM1KJR9Njl6i4LGBOiKuIYxARdZVrI19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MppLQTdvULyhStswG3VLps9PibWDvRj4CyaGjSa77tQ=;
 b=ovLlsW4b2HxIzvx/7kiFdIj9ySa6vsBopAZ/fTF6J6rzsQZnNzbQTmNeZxDWwmGHBB7Y6ebyHXT1rWRR8DFqSWbV2/Q5mDb3chh1Dz+UjUL5xIY6X51xc1nBo7I8kdxeSNkK7xHlTRekB1gDvNIqZmE+WmQwvdNAJEiG+JQO9qTKOQWWDYcQCrTWd19kAQGndrjZ3D9hFkroJ50wvE39k5Ffzyoaj8twkVLqzNL4oIBK6e6AE3CAJXiU5+KDiedj5N4AjkSNtMREFT1GR21jQo0cZzbbmn1Xdl5tDw3+qF7sXKKqlE++YfoVDEIZyLNvCb4lXc8EXKtivK6iSwBPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MppLQTdvULyhStswG3VLps9PibWDvRj4CyaGjSa77tQ=;
 b=kzOeSHsvwIkqjpktiHISMBCi9/ml4Cn/gSUmCGSNejlUncPPAjXYKI+773BGkj4BN4mow7SzYSt536d03IcxqLvC2gBQWcfBqEF+VYeoN99CYv7xdyRRgNI5OEzHLw8td7qNEFyG4zFY5vReaeBlBoaJywfOVQZARGd0GMEemy+4o8A4ZJbeSvVF+QurdmeQdE2MzUS6pZDpZGuguyfw0JxyH+TEgUgKtaFrrO4TLVwIUBovHHBtrkhuPEtxJ0+NFnW8vwd1Kow2Abfspq9OLc282nWCRCysljCIAy/53LsCc1dPYblseNh6mxtqeuTIAOs3XdFiZZVxf0LqCNV9mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 15:32:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:32:01 +0000
Date: Thu, 13 Feb 2025 11:32:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	shiju.jose@huawei.com, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <20250213153200.GE3754072@nvidia.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com>
 <Z60QCS6o-3VInenG@x130>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z60QCS6o-3VInenG@x130>
X-ClientProxiedBy: BL0PR01CA0003.prod.exchangelabs.com (2603:10b6:208:71::16)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cef272-905d-4202-60d5-08dd4c438fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXyEk6fzKbYki+dcGjt6QItNR2Eln0BQEiPtWR2JrZhc045CnSHxjFqnyzFl?=
 =?us-ascii?Q?6fmVsowshhUcyOs8yeDQQJU6PMMB9m3S9rDNtPshx2fkFOr1dx50jBIxc6mh?=
 =?us-ascii?Q?t5zMY7GFyFlm/5nX+xcm5CrLWmyWlI3qQuf5JCIgrF9p9yOniOtYJFWUJHUR?=
 =?us-ascii?Q?vNy+cGEyDSco4g4iifV+pTPQCiG4GSalnxYEUr0o/uU8rC6FnHEmJxUB0NBJ?=
 =?us-ascii?Q?cDBOt7kR2oTZoFBXyAUJZdSwn34iWP975l+wep6PZnp8xsJOQq2jwgZ7m2+2?=
 =?us-ascii?Q?ZyneuOsr6K/mDAiKOENml2Av3IUAcspii+cdd3WnJuAjX56GpE1Pd3tpwQn2?=
 =?us-ascii?Q?mgxkBOl3y0jlouM45jMcTcBaFTH3fIKcnvQFyeezYczcJ/sakV75VTHslg1W?=
 =?us-ascii?Q?3Mjip6rTDXyTdrwBEExOJwglbSv65p9NwTcOcHiKslfbHxQXB5MAhpC7951p?=
 =?us-ascii?Q?C0rG/dwrwkVYxnSifAxLRUUUH817COJTfrsv07HDNeIP10VcEMBQDRi+HUqX?=
 =?us-ascii?Q?baSEBCE2nQhk+PjixIfT1CoGrHmHaMfbbNlyxltrUlj6hniOEHhyiuycsKpF?=
 =?us-ascii?Q?XLeEzRiCe+gKbszPatfR6SQhx6+TN6DMQVD08h9GkUAjZkm8cxFlz4rUXFh+?=
 =?us-ascii?Q?VReOL3eLy5cAfgsmO1Sm8Zvbp9JspApP+4cNgwUxa1pT4GvxdJ6VKIhuFxAo?=
 =?us-ascii?Q?J4+lZmS9WzDMrfGxqqwhiRaZudREtbinkjKSJ3DxKFoGJhK+imzV6XfFZDl6?=
 =?us-ascii?Q?Fa6bSfyLGtZ9ljTOHfib+mB9vlPoizDae0JQyye1MHH9s2sXCmkRQalKEumn?=
 =?us-ascii?Q?D6YDwE7A0mtRmZlW3JO147eGhn6WFVC90FMZFiUWW75VcxRMIltj/2m/Qm3K?=
 =?us-ascii?Q?ZYyC4vZfGWUS05wc6+KCAn6NDC7u1z+vqjfTLvcw083vaXAcQseIyr+21VMY?=
 =?us-ascii?Q?wdoLGEwINN0enMLwVunRBjfApm60/9SSeM/Z5Yx0MdGFruj3EjHwybgOwXph?=
 =?us-ascii?Q?HAzxw+AshbAJQS5mSVwKlXnfwWI61wt7l00V6eH3M7f6M3oeCQK6l12/yJVD?=
 =?us-ascii?Q?Zpf8X7lIFfENtR/OCkJPmZYDcRQLG6Wzo7W7P+EJrXrL5HUwSLwb7eI7CUar?=
 =?us-ascii?Q?+nXkappIxWvpzG2XgK6jGaIkke6DdM73xwLsccMa7wc5l+BY9zPno9cDaFvh?=
 =?us-ascii?Q?axWju3JzUo8VIO8fQTQAKsx13aNEor8YQ4VWitJc7vy10s9FCJqm1z+epsUn?=
 =?us-ascii?Q?tNsAK8Emo2d4lalLsTu0Zvu0sgZsoW8vjDppzXlGcYDXcUL5T/0ljtWkmvP+?=
 =?us-ascii?Q?MbD+3SBkxfenDFLpaV74FOVfEPapHymkhqTz9sIqm7EdWRQD2by6o9G9q2Xn?=
 =?us-ascii?Q?xcIB72kveQ/L4c6GlNzPMnSE1nuh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XF1SneTceIgJojVlO8Eqnhgsy977RyBKGfxJRcCeeX+hWldl87VF2SI8rdL?=
 =?us-ascii?Q?6v0InA0iwk2CPNMh/zslIuc6z/4IA6xYP2zvj2lE5WM/IgriAJmReDXNLQKV?=
 =?us-ascii?Q?BJ9PBY1xPmk8A6iIgfvviSs3R/C1+AgmsCX0/mHdX4HjAw56YhqP/z80RDj1?=
 =?us-ascii?Q?Prg9D7RR49bItojl74X56FtNKGyEMnFrl/h3tOBN0oBpeEyhOxlZMh7f+kDy?=
 =?us-ascii?Q?RdpEDaqpGLiaLiv+S9S+vnzYcqgIOFtieKj9Lfj7YiC/KD/KanOqTXj7ekLx?=
 =?us-ascii?Q?ZZPM7SlebkbhK7sTn54fuxhmc4Yj02MtW9qshOHL8ZYqWbdu1tTj6nVFCuAt?=
 =?us-ascii?Q?Z/k33BGjxVJ1xpl+4TcExviyUne6JrjG6czREvn7RcpIghWcjsb7IoBEm6DB?=
 =?us-ascii?Q?p5S80TkCuZ92m6SGTlbflUcO5kV48rmHIqgu0xXAZCL8+FQ05Sc9Wy26Wa+8?=
 =?us-ascii?Q?4w/tr1AJrHefdyza6AgH49tVGHBiSAuu8ugOldvIKxEnGvGhK2DratcCRtL8?=
 =?us-ascii?Q?NsMel+PZ8XCAVZR1nAH8clLY2OTJp38BJpy2xKSd0tiy27Gkc2fP5VsdW/q1?=
 =?us-ascii?Q?Tg3N5kBKgGQ/Yxd33rmmFRDeYq7yukOZM7i6UQ438rK0gCq2VrCrrNkbj1wY?=
 =?us-ascii?Q?UjrMsR9jzKHqO56G5P+f9chIp3mePOq2n0E16VBpc/W0bmItOgDTisIO7j6i?=
 =?us-ascii?Q?SrTj29jg7QlpuOhIFHxaqRdvTCQN0lkSnU6ytt7XSOKUOV7LnI50kpjQDrNU?=
 =?us-ascii?Q?H+WSjVVwcHGrARFyf6n0vvLcPLNKQIIyB0xrSxhZ98ERaKVXi7cICcSxEqwK?=
 =?us-ascii?Q?wDr2/9aAUVRngwpHnzQdOkYHJzOSe7eh7CR75bPWSotZs+CVMbhRQWI08SoF?=
 =?us-ascii?Q?CPJA7l7bugVm5M0YH5nxY+ZxB992bT4OYiY0x4trYvGXv4kylCpLKaySHPY+?=
 =?us-ascii?Q?gq6YFd09vOpI/KEF2I0GJ95IOuz46xyMAbWrH3fJPUmtsfiT1xpDZrdYpqXK?=
 =?us-ascii?Q?oLdxhQlReHsHyAp8GkuynwDVc7c0AorwBhM/RKg3zu4b+HgeJFneEPBO1tsl?=
 =?us-ascii?Q?jjr7G1a+GJy2ZWkKsAuMu3cyrUVMxORRmJeBAgc2LKtxPPp7XBzk5Em6S8UU?=
 =?us-ascii?Q?14ljjl2lr3FN2DmO5qMfgfggKtHL3VSYvl8kxznm4hUWgXWGwUrK8n42t51Y?=
 =?us-ascii?Q?Gw+/yKURi/JwgGC4REp5aMPzBRzUHBoqS/n+be3jYjEY0qiPfjoYPc9RqsJL?=
 =?us-ascii?Q?EGOuO/1OcYdPpk/5YQevz/0FPYvSmio5pt7yJCaEKew27wq1rzagzbHOn25z?=
 =?us-ascii?Q?oLSEmeMSEdxreqR3Bl9l/uTGwZuIAHxcVdSzUixzE3kbgQg0iqRDQGFKryJA?=
 =?us-ascii?Q?BbDDk5fC9QnGOdrAVyPu9ZfCEeaAXz7aqFQc9t9ULKWLgqBgUTVFkJsRdaTL?=
 =?us-ascii?Q?Kyf23a4UQLEhcy82vJovib0sp/QKfcV5AFNIbGNBYQPQxjMN846ws/ncgWr1?=
 =?us-ascii?Q?3fPXPIkSkbTWOQeSVmyVEH2u8jMFzud74mM0+6N6bAGNwmLwUlVTSyKsL2Yd?=
 =?us-ascii?Q?vmojA2BygSTfAo+7G8ZCjR1uuHDldFwcn2fvglr8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cef272-905d-4202-60d5-08dd4c438fc7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:32:01.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsRIoFUyC0PTy3Wwyscl9Qp9tYYqXqvoVTzSHv+dVpZ4ixoFhbDRdrRtmXrvkyPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439

On Wed, Feb 12, 2025 at 01:18:01PM -0800, Saeed Mahameed wrote:
> > +/**
> > + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> > + * @reserved: zero
> > + */
> > +struct fwctl_info_cxl {
> > +	__u32 reserved;
> > +};
> 
> I would add some useful info such as: num_user_features, mbox->feature_cap,
> etc ...
> 
> Maybe if the callback is not implemented by the fwctl driver, then fwctl
> subsystem should make sure to return a default info struct or some zero
> response buffer.

Yes, lets not implement an empty struct. The core should permit a
driver to nop this

Should I add this?

@@ -62,7 +62,11 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
        if (cmd->flags)
                return -EOPNOTSUPP;
 
-       if (cmd->device_data_len) {
+       if (!fwctl->ops->info && cmd->device_data_len) {
+               if (clear_user(u64_to_user_ptr(cmd->out_device_data),
+                              cmd->device_data_len))
+                       return -EFAULT;
+       } else if (cmd->device_data_len) {
                void *driver_info __free(kfree) =
                        fwctl->ops->info(ucmd->uctx, &driver_info_len);
                if (IS_ERR(driver_info))

Jason
