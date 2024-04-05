Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2116.outbound.protection.outlook.com [40.107.92.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D2171E41
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340578; cv=fail; b=k6m1C+etQ4L80mNwEiBmklXaM7r9yffE/KLK/rN6FJadVLDppjPMEv2gfJtgvzoFPOEcCYiRozEEZixXID+Ej27I+M0QtaJbtqRDZ/uNlgh+FRKpci1svqUQLTmap9gZjBbV2119/f9QhMd2cNpnWFv2rC6Yz0QbnRHg8QyhWsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340578; c=relaxed/simple;
	bh=22+ss2KB/M2x0LvcGrnwfzN60wf3tQ2mV0YiOGN+MW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gu9SC/f4DZuiZvfUOLJiGvE6zrmnsIFaqNUTBCEUMafeocnBOBgJCEFVAW+DI/ZyXvcl15UrnNpf1Mc+7LpmHAx4h+bUbry3Q0nMPRB8VwxkuTs73xBD7yVuQH5qNgdQrssZ2xfzEfeJy2nE9URQbAn6rfErrnLqaxYzWlQLuo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=J7irVMUZ; arc=fail smtp.client-ip=40.107.92.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="J7irVMUZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIA9H90lXMY+IoDUdHJ7E4U9n0dN11G19mOTNKMvo5bm1nRy0dCca6Sb8AKlOvcO2hG3TLmZU0MHK25j7jJjximushL4AX0T5OgX/eOJvHYnEYVCk9Mdy5fTjJztoH5bAUtVPAEIPoOHpDZkpe0UOlkWddI2dba4sBvkzBVTEsyYaT/adTPB0hSemD6m28VDBf1QL9JZDUulF3I6UPNEQAentNt+K50ukASA7kFX9FsZbE6yJfm96nfCbcqq9NVaI+d5PM5tHW1hAvutmsXqlQdKk4FeIqvLwxqnv58Yk5cp8+NS8RFMA3GNlj2yWV2lZzuMJSQRCU/sMD34eBZGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BtMTm40+9iEB2oCsm+2oo+7rT2ofANm4JznVqfF0tY=;
 b=HkjE59kWj0pF7rgckggMnaxJKt2RZ3lceT6h7Wr5CyssFPSh7NeW9UVEHPctF+INA7s8stvQdyDBHDYMrf7W2vRvopgF9w+yzhaNpy3kHHejlszjl+Bd1Ij3ZrgQktgR5uCNZAAAijlDBIJZuVWBIp/BJqIYN4rMTALZoecV2NKD/321suuRpdJioAGLPX1tMyPj4AG/LRPl+a8KSBX7l7RGPcos3sxDb0BdJsyucrVCcTCGdV/QCY/ukwT3+kXXBgDj0c/7kyTPME7GwtPgzxGUNGeO1m1rTlmCqVoeplJGZkUvsQahSNJoEAEqsY68FcqC1S0URcHpRhxUe3e6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BtMTm40+9iEB2oCsm+2oo+7rT2ofANm4JznVqfF0tY=;
 b=J7irVMUZ466TgeVpJfY7loLLPHu8UqZ8HjttRytiventMgxmM9LsPAe3JUdiA7XiWzRPaWtKdS7gBvE3c2iKO44h8pFyWSbDIW5VHOZC6C8wl/cbsxAiF9sDmTVqdvPXfmSWn95ee2x+pb62VpIakXxlTb+HwsBYkjbKNYp5VEs=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN2PR17MB4045.namprd17.prod.outlook.com (2603:10b6:208:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 18:09:31 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.049; Fri, 5 Apr 2024
 18:09:30 +0000
Date: Fri, 5 Apr 2024 14:09:23 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZhA+U9b/IVq1V6LT@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
 <Zg2c+YauNGqhFfTW@memverge.com>
 <20240405132719.00005859@Huawei.com>
 <ZhAh0Qmv2/VTe1wT@memverge.com>
 <20240405184452.00007986@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405184452.00007986@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN2PR17MB4045:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+0RGWRJ24f/0q50YUiDR0U2UDYtWKdbyOu92QAI8q0EF+SAV5c0Y3C/zgVpDRfQ2EUVPNbjSVK3CsmsFKkIDwS9DVpIlE51Sk/tiCT2rjhZFb7JmPO2ec0K/c2HPrO+tlGTbH9e0ea3fpH+ZCDnra7YWOaPjOCo+9nwRByJQrfDwJlYDLRUzBjkkRF8SJ8KXUwk9mO5VcsLQvJM4CO0nK5sCGRoxhp0kELhRJosA3yKSDkJHpRQpaSKP/hwAk0xpbTmSaGP//kiEki5tZz6Rnli/vJfCE3gKSQlnpr8rn3TllREg5J0uuBoWRp9/XTLQmlidvXV3PsHA/kNOhR/MZlGEelq6dB/RkABPJ5xrva9ZdOEUc6A5GFsMVTylx4To0jvAZ1scHDygDzBNzegDZ38f4ppr05a33YXsflq/lt7TjTiSYRrMo9BtkhGCb6P8+Uqiu8Og0aWyvuZYOx/z2IrAvfsgeCun6g1zm5VD/gMgcP2NPpK4qsccdY8mYlehWrH2dpLTBjSYS+GDavvec2tPXPX8XsHvUoHLwXzMLIHeU3RTS5JbKkATY+c2THh0dbTKAewMqf82dIGOlJHnnz77upbgeoyjSuxZYJD3krOv0dKRxurDIDQtSIn6YODb+K+nvbs7/lYb+Vc4wJ4A/DKH/jxbFOsl3uARy55GXjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tA2/33Wzi5B4YrJs1kpminetOs6yX+JtaIaojrIsfFXX9oksXNb/HTRI6UhA?=
 =?us-ascii?Q?hON67O6woQgSlmvtVzaH71EPPKi8MLMYq6OUbZbaJsaQfeQv26iy1bUW2UxK?=
 =?us-ascii?Q?0l/MViTPUPEJbq+w4hSqOJMFoiHfhRM2SJYl2efeP/aKrVVhjIjfTlQ3T6P2?=
 =?us-ascii?Q?/sy07jesjzyL98VeHIKFnnml42Qp9XRc5c41G7IjwAF9rz2VXxk1inrdVCdi?=
 =?us-ascii?Q?T1hR3LnWE7QLxUBSNmKBBL39SQ4EiGuOAneNae5ZgXjrr3PKPIE5fp9DAQyY?=
 =?us-ascii?Q?v5lonnKoMN0WScehRqPI4opL7gOvJ08KvCXgYyadlKOBL1PE3vG5A4o8IQNE?=
 =?us-ascii?Q?SPnDetwItCTaw7wzUhDQvCWzz+EQh5kc3ffp0kPM2Z1R7m7echURjxSn3ssj?=
 =?us-ascii?Q?j2dK8gnx2jSKCE/Mpbr7taPHr4AFrx8mspCT6E+9G99ZesWIWl6LcFKppH1B?=
 =?us-ascii?Q?KxtZ3nuNreJAT3mTfXfIHo9WSe4c4QL7Yq4y91LYmYpN9NjBmjJUZZmqmQwW?=
 =?us-ascii?Q?VrdcLDGDkij9aResT+n5sV3mUtiihnjeDVB4p4FlJ7CmF6QmcfLzCfh4kxOz?=
 =?us-ascii?Q?aI7u2dRWCUL+/ueW4JbKec4b4SGzMgRNc18nNGeZZnYSRusQKyCu7lKzQPg4?=
 =?us-ascii?Q?XmKwtyeetSF8Tl1GGrBAmHCrzSnm5lCGqrRLRzH0tHAZrm5ms6HVpCZ79DGR?=
 =?us-ascii?Q?av0KPJWoms0ZKVlv61/ysC5ZMAtR2QaVZWlEreRRsfyzSihz5bKtUIXN15nx?=
 =?us-ascii?Q?TgKxl5nMUy6+79mHL752japWOBO7IHmrCak6WQEY5hUkKFsJ+IaKZZybxg7C?=
 =?us-ascii?Q?WfsEjS1WeWJBSFu5NQtv5dEw4y4S6GR65HC2F1fyFintSM1QO3AFI3MPCPao?=
 =?us-ascii?Q?GXJ9e2PHHCjo3G4Pw/u6QayvbekjOUmJUpTHkK5InznTBd1SdV09FWbXJqBY?=
 =?us-ascii?Q?tB5EJyFXb0lIssJIDeC0rP2kMcAfgihfvtqKrX/6q3AI9/l2aDSjw71N2icb?=
 =?us-ascii?Q?8buyCMg3LdLvf5zMgt2LMHFK6PbLsB5PbF4UqdkFWEu9biFcKrkhPilR8b8N?=
 =?us-ascii?Q?zpNiAPhJNxO3zY7+UHyCncLzr11Fb/fn1phZfB2RY277175GxrCnyGg68N+A?=
 =?us-ascii?Q?dtj7IcfnU/BegN6lrFqbb8OHAhp5mAQGYqsCErqtaPEXSZuIlW1N3CMmpVdY?=
 =?us-ascii?Q?BCVPbio+1PnfZo7KGPhph1V1qAI8DTCVtJ22Q2XLXQQpn4UStJ1bzguICqrv?=
 =?us-ascii?Q?G+qbeDnhPCXhiH+MXKFhc/72utFGv6exSRUbE50PcwojSigaZujY55H1VL73?=
 =?us-ascii?Q?g30opYjrAxiY3t4PwmrlOjSg/cLh7OQRVUZF8GyiMLH+3tmLD/wfMRbd5X3E?=
 =?us-ascii?Q?3YPvqre17Njf6I3wFUym4Zsb6nB0rQlX4sy2zVGraASVak6y7S+L6wV1Bp7z?=
 =?us-ascii?Q?7a65snkAqoXrulqU5OfBKx4j0TM83+CpEap4ltzeM09VX9rp5/qD5zgf0tQP?=
 =?us-ascii?Q?dwM0BLklANtPl3nB5YrANBiKOcBglDXsmpSSSyvkDTN19ncozxiHpp0esy99?=
 =?us-ascii?Q?Ppv7pEqCScOndnDJI7z6AZ9UjMGNfctDOleHNqLDM1JNjG21iBZ37CoNjyL1?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a049d7f-dd81-4d02-a70c-08dc559b8a26
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 18:09:30.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9mkNvhklQtbWlyyCRnC9MH+MlW/fgkmMA7dtegIMKgAHSv5b0qt+lykH+Mqs6hrGgtKss1Ls+86iomC/WL/yzcwPQT6VBy9l7UtgxsCRpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB4045

On Fri, Apr 05, 2024 at 06:44:52PM +0100, Jonathan Cameron wrote:
> On Fri, 5 Apr 2024 12:07:45 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > 3. (C) Upon Device receiving Release Dynamic Capacity Request
> >    a. check for a pending release request. If exists, error.
> 
> Not sure that's necessary - can queue as long as the head
> can track if the bits are in a pending release state.
> 

Yeah probably it's fine to just queue the event and everything
downstream just handles it.

> >    b. check that the bits in the MHD bitmap are actually set
> Good.
> > 
> >    function: qmp_cxl_process_dynamic_capacity
> > 
> > 4. (D) Upon Device receiving Release Dynamic Capacity Response
> >    a. clear the bits in the mhd bitmap
> >    b. remove the pending request from the pending list
> > 
> >    function: cmd_dcd_release_dyn_cap
> > 
> > Something to note: The MHD bitmap is essentially the same as the
> > existing DCD extent bitmap - except that it is located in a shared
> > region of memory (mmap file, shm, whatever - pick one).
> 
> I think you will ideally also have a per head one to track head access
> to the things offered by the mhd.
> 

Generally I try not to duplicate state, reduces consistency problems.

You do still need a shared memory state and a per-head state to capture
per-head data, but the allocation bitmap is really device-global state.

Either way you have a race condition when checking the bitmap during a
memory access in the process of adding/releasing capacity - but that's
more an indication of bad host behavior than it is of a bug in the
implementatio of the emulated device. Probably we don't need to
read-lock the bitmap (for access validation), only write-lock.

My preference, for what it's worth, would be to have a single bitmap
and have it be anonymous-memory for Single-head and file-backed for
for Multi-head.  I'll have to work out the locking mechanism.

~Gregory
