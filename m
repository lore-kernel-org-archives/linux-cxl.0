Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961D15DBA3
	for <linux-cxl@vger.kernel.org>; Thu, 26 Sep 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372250; cv=fail; b=tEiib7lZBnZ/kgaBpn47M3/XdecG+EHVO0Sw9FqcCW9sQztIlCTlFjE5IbdjWNXtaxYK8vwuDQME1lFh8liTs5u339PbRSFB251itEDXi/6reERZ8yucmKs3g+PabITVQGFTgvxcOo4ttCy1NGINks4pzX9znkTmgKfmA0XiMIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372250; c=relaxed/simple;
	bh=wnOxVJs74M215rdIrberOpSsGAe0ux4t949VGLBqzos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CauEgaoPgs+/KXP/2g3PGnXEsxyQYMw5gUsni4t29NwJzGxaLjYlYhaENAAm0fwYnjiICYF76FJSuR2w2Jt5kmb7DpYN1VdCj/SsiljBGcRWQvI75y0GWDZ13RVxFgHbG+eEKX1kIrVEQPEjEFxDtCwL0vC5T1dg3Zwvr5vAZ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rBFxlOdc; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rBFxlOdc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+KPAr6YaXBk0//o0zfwshBkJQDMN+H7a02slEMYEmJYRZN5eQcdIOIKDOjZxs7AocLN6htQy3ucSsDRLZXYK+UMzE43Zb4i2VSZIztnroDx/uzmxP6VN5G+L8DZEalJK21RgVSd7wuxtbix/zhuYR+yegd4I6HMiqO1clN29442OrvopfSbQO6zt7aRmF26QcOtUMCcpc/g1KewzIdbQW2/NleopjCHVf21Z9KeYMJlzRRd5AYyAlgNGsXL3zPzQO1N69ivUZWvzG24uZFYef7HbLypXsPRuavN6OOikA+P/PIeFD4Wp3yFCx5LPgZPR5bduVbLhhFBxEnMGSYyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXrc4lBxbUcwH+ToylxVbDA/ZepqJVKHDNVqnldYRVs=;
 b=WwQMbAoAXVgZ8Cu69g+hsO9nR1/CJagd6wD0evL+FuzJ8Bd+pU6rpJDl+5DlR1s/iSU9sjYNIQW6QDuziZF0tonB3lJfUvt7czV8liXj306R4AsLVpkYyVgaqDKx+wvfaV4iHzynUnKvq28zlOI5u5a9B0+XJbliuHa4IxMaw+Avmn+dPvqG3VxoXPgjyhXP3vhDzu/WmgQ4abU3E5GNVNmCKepXMP7ZuD8osQ5vU8gLLl53FSGTJbC0Y4Rdhvz8ediRhFrZQHak+cZxiEZ04jXavyoUg/lCnC7JtKr64uhqib3q/ktK3eQrCjgOwPh1dowycccmPAwIrc7gEC6FYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXrc4lBxbUcwH+ToylxVbDA/ZepqJVKHDNVqnldYRVs=;
 b=rBFxlOdcTHCeBXhrwFsE3g59kjpZDBf0cXhbx9nd5cOw65Xv3cOAFPj+oSm9+NHfyq2FTdiBlXKcMmCwQJR1IAUReqA9VD388eauXlPjzV27x1BnDLnoYGE1ENLym7cuIR4c5zwxJAACGN2gN01QcFO5L5s0plqmiLn8yEHtuJtAOMobe9l/YUmxhdhq9uA/llpzvzwo35tE1Gakw/BA8uIATb0uW4ZTbaVnhilJvOcyCqnrqL+9Cnp7oCmeVAett9K4trUg/YLcuZTN8BBx+DYTGyWDIheynBEjUF21vbUXZ4Icc8w9yfPczQOITEtfLdkjs30qzo2JkZ4zrXre7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 17:37:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 17:37:19 +0000
Date: Thu, 26 Sep 2024 14:37:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, dave@stgolabs.net,
	shiju.jose@huawei.com
Subject: Re: [RFC PATCH 08/13] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <20240926173718.GD9417@nvidia.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-9-dave.jiang@intel.com>
 <20240726190257.00003a60@Huawei.com>
 <f57c9889-450f-40de-a3be-55c1fa5d7eaa@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57c9889-450f-40de-a3be-55c1fa5d7eaa@intel.com>
X-ClientProxiedBy: MN2PR19CA0027.namprd19.prod.outlook.com
 (2603:10b6:208:178::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc4dce8-9af8-4a2c-06b9-08dcde51df0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eyaO0VqaYq7L/mSdB7MqIwzSPBEi700Ym8ODNSwQqLy3kYF+9mUwl2FiY7Ii?=
 =?us-ascii?Q?cd+IdnVavMc+bP0mp+4C8i9gdfxTF8lMPlPtKhInH8ZrYkss7kdJ18tWhUL0?=
 =?us-ascii?Q?+O50FrdgZoXSq1Y9+f2P2KoPXG8ZhVStS7gt/4FsTyOvcC7fPqiCcGvKW2pd?=
 =?us-ascii?Q?YI3jgC2pbvChAP9bfBa8XZI46rQK66nlDxSVCUD0gcj14oMqnPScVnKRYowg?=
 =?us-ascii?Q?xj+OduepEn7QWIXcx7UTxJsBSNt4cbzFp8eu95es7wG7XO2sLpgrVAbEkL6V?=
 =?us-ascii?Q?Uhk9ERYCSO2T/uhb+vkujjJWyRmF7VCcsm4pm7mSWwsAJ2UGD9pTKMoIWURU?=
 =?us-ascii?Q?ro7PRRErEVpbEQ0N590RmZdRqokhkekJqBtBIloZ6ctueSUDWNsRmLh/fSuf?=
 =?us-ascii?Q?aO3CEtDGptBub63iXLL/RCmSKCYfJex+j2DNmp9rzJxAzzd4KcPDpk57PspX?=
 =?us-ascii?Q?iip7Cqz0VJBprA4ujdhtftmjjfy3gzlHihewwMlLj7hk7rjMsbcbMMULAono?=
 =?us-ascii?Q?wWnmQqUoKpD4t1GZ2k0qpPdxwYWNF1V0Jx1KCB2Zluy+DkN+0/+Hkr7m6J4y?=
 =?us-ascii?Q?AiypMbruz5RmnMLKkF7WnAg+SI7V9reBFhtTtPlRf3t6fVNOiW7aKnKPCWCe?=
 =?us-ascii?Q?Uisx3/OC3molNkiDvtrks+wlpg1kp4bIcWRBVMBGmgb9NogPwwizUBB3BQRT?=
 =?us-ascii?Q?x1dtyWNZ3Wpx3tZx3fJZGpud3mZTe6wc1F3VcmyAjcrYztRcw6vppQlvIAMb?=
 =?us-ascii?Q?p7wei8P2M3T/FzkIIsK2jFmau9qojsLi5B6m7I49wP1w/di0EbS4zP8AcqZJ?=
 =?us-ascii?Q?uhaAJDwNLQ15Nd41V5x7CmHH2zEId4c+N8iz4bnL7CGqmi9ajWQQmhW0j3Y2?=
 =?us-ascii?Q?V5CwSR4qIoI15vgpXmQXMh5LAecIk+AB7X5uqDsBpLJRb5KgS2Oc4DKR1Ws9?=
 =?us-ascii?Q?1cknDgYsyPTjQUaVuc/SeoyRNjk6ltrONVPPX8RhpbVxA5IsJaMVxtr7bqnl?=
 =?us-ascii?Q?vRQangk2HWNVN/Aw6e1bFjX48aOHDt81QadnI3seJfw6xEzBMs6XX8GNt0GP?=
 =?us-ascii?Q?lP6JToIjw7dOE6wEHrzIYpccmPIi/+eQW7zY/sITrM4pXF8f2t88X97ZU8FV?=
 =?us-ascii?Q?TBrefoTsoMjwZapfRCE8GA7yuR3G1kuPLnwaZL/J0muOVqN4c5i1lc5KRTUQ?=
 =?us-ascii?Q?0/5W9oWsnwL0Tq+SNNAm3T+fppV17pImoIYiWXq2zPUagRx+gaXVN1Y5sIDt?=
 =?us-ascii?Q?6jaG/coEf7dLx2Y43KEzgn5PySGJNJzTV0SnlNMfU79N985Vgba4Dc0Q1zfn?=
 =?us-ascii?Q?DbmfqRbY+RULZj+rMp6yLSLIaIgHt/IinVMRnWZHjH2fig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JXiD2sDZfMWLeCxZPUE2ob7HPfyfMhRWRDLbtnV1e+6CD0LZzpOwd7VR3CX?=
 =?us-ascii?Q?Hxo2zgo5XAsoTeLKcdYyqRTK2vX7Civ/1/Rm9/p5MGRE0VIn54ZLv6XFPdUy?=
 =?us-ascii?Q?N8lHND8mYJvXZotgZHwxARovpDaXLmSxXNoAq7CX0vHXhfQKofwuN/twa2Zr?=
 =?us-ascii?Q?OmCUJYm3n6oORauRmp1M3HxW8UvAfuDtp0tTKULMz7Piwykn+S/sYKNR5WJ4?=
 =?us-ascii?Q?9SZQ249bBPGRxf/zb6Vt///xWx2jewT+0+a6fm2c4w34hOwOG5grIASV6i1f?=
 =?us-ascii?Q?9gWvk2FLMF3//wctOOzst/D8tcsrZjYDfCOzBuSRCm/7kDHRLZIglFJ5THjQ?=
 =?us-ascii?Q?soxXNOZZLe/NAhTMVoHG/smFX0Jqq+zWwFiKE0Lfk0DOEYRN985nnWvnowCt?=
 =?us-ascii?Q?BUHG7shoy1FdFXH+osLbd/OIpN+iQwS5WkaKQd+l9r2yoVV3Bn4TNXOlY+SF?=
 =?us-ascii?Q?O8GfWIgUEmTGE6QyyrWCrvSZ9/AMR6qyfzp0PIehhpGDYIfm1B+NPH61g5K2?=
 =?us-ascii?Q?e+A6w8qdqMFoOJkqpEWNktMK9K6Jo+SPY37N1T/PCa3v2UM1jxxwtqVAGyIE?=
 =?us-ascii?Q?nob63Bb9tDn8PRkKnMs9zlu762Hddnql8MvmM/gX8HgoDWDp8uvjf2lvJ122?=
 =?us-ascii?Q?oQLuyELYymhvQe8UEvZ44Sf3Les8EsMyP8SZAzO+p+U06++BnXkLThXFBg3Y?=
 =?us-ascii?Q?HdouAEVsAXK92yeLXYFWMN3tfuTrHOQLZX/M4bjSRoE9dC8G4wMe2Gdy2FwJ?=
 =?us-ascii?Q?MWTiZxT4IK5fxBw2fYoPvCrrqPAFUKgGdqC0B7iaLDD0UMPfL+rnNpEuXmzL?=
 =?us-ascii?Q?dh4ND/erjONxg7v2kn9aeMgHz+Fo2jnudE9R4iQ2QJqkTkubqEQdGZdWGjfz?=
 =?us-ascii?Q?9sFe9Xfbz7cRiHNyPHte76GkWrkFy1YOfOrTIHc+oFsBT13f5ivI6UX7CRGJ?=
 =?us-ascii?Q?dz1uuREWpJmRrQwgRQ4auKb8YWGSPLEZddOJ3IvvvHqZ6PaoVgEXhu/TixPq?=
 =?us-ascii?Q?WybtXyTLTHwn3EIc3rZMQEcRZU3eYv4EJ6gcp+hmm13d9arJ8eoXb1Tk5iWF?=
 =?us-ascii?Q?9VZDEXoqfkdjkX0PLBdE2RD3x/zqxjYMlBO+PwND3+dnBlRrNPL+2K7VAl0W?=
 =?us-ascii?Q?SmfrTeQEPrbg61bnso9bMkba18nt6j4iTAL18P/0jhQf6Wwqu5EZzgnF6IQ3?=
 =?us-ascii?Q?ZSCkP1NeAkOtW7Uu/AS0f85mmuteG1+dDNckbmD1xmFlXbjSjUgLDhqG/OUl?=
 =?us-ascii?Q?cusqVIxeMoI7lY9t2gb27jT4ydczmdL1T+OJHjqrq+HbQP6T3jX5kJ/zuD1R?=
 =?us-ascii?Q?mjRiy73IsICxZ5qkMu+i+czqbC9v49Jv9WN5j9lArgzi5PrE/p4y6BzB6EV+?=
 =?us-ascii?Q?gkzUdKd2spJ/pwut48Uvb29YW4EblnrmrqnJhcrtS/EsC9sMnrC7WdUry6sy?=
 =?us-ascii?Q?zl3PIjQ+rwTg+G1SpGEDnyLFSgr9o6eIOpSnRFYlhVrNswxLH0LeFZ0PXVCM?=
 =?us-ascii?Q?j+7Ct82pzLl+HXJNPoN3dQ4yNq1CosMdx3Ab6fcCWQXTrYNE+QATyvWuR2Nx?=
 =?us-ascii?Q?y6VMqAPRPdWFdsgzZj8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc4dce8-9af8-4a2c-06b9-08dcde51df0c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 17:37:19.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWwFKDgRoKwTKuvLQxo0SU1Uq0gx9bQXc7jGDxSUP9n8OUzs9h/BpRaLEiNWyZQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442

On Tue, Sep 24, 2024 at 04:44:19PM -0700, Dave Jiang wrote:

> >> @@ -1030,6 +1032,7 @@ static const struct file_operations cxl_memdev_fops = {
> >>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> >>  				       struct cxl_dev_state *cxlds)
> >>  {
> >> +	struct auxiliary_device *adev;
> > 
> > Why an auxdev? It can be any convienient dev to which a driver
> > will bind. Why not spin one on the CXL bus for this purpose?

IMHO bus members should adhere to some kinds of rules about the bus
itself. Devices should have the same set of paramters/etc. I don't
know what cxl_bus is, but I'd be surprised that something with that
name has SW only entities on it as devices??

aux bus was specifically for SW only entities that are just for
linking software components.

Jason
