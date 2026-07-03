Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBBB2877F7;
	Fri,  3 Jul 2026 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067963; cv=fail; b=W/xXrHC5I+kBM7WfAtqvLucC3U0Wd18szYMXbmVj4FS5V4XiEEcvhslm60Af23BF0/zj2E3eQ6U2sRSjK+XS127VmSw6jivpe/cK48U3dKb9Sm7uLIj1rh0dNUM28iNpdYM8EJ3VrNbPEiMPwDXimigMbs3rQ53VlutEUh4WkHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067963; c=relaxed/simple;
	bh=m2riOcdJrUyVadmY3JOIGahutKucTDFYgNGVHS9fr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUYV1FMQXHuS/eeHL+MolO+QN2vIWp5o4rhsnp7u5WvgUuGPz0mOKeDQDbDMJY7XYQCxNRhzCU9JL982Jzvx1Br2BbV6FiwGinFr3p+2DQBvUoVDjZ0zZmEGlb2IzZWqIUxVXfCMQwYfXHk3x5vxAg0kgPjFHQDMbvgGn4yPmXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aC56TONb; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aC56TONb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/LejUtrA/lyUKg4CjykvdZNwQJb9CloVHLyyKVCDLUvE6kBTBVPRNUTb0jYUwIUMYPAe701XZhCDxyf0UBDlH+5oMI1qYLe8dLPli4IRG1GBoLwTXtQ4zOgmTYbGmj+yTAcAhjaS7k/zLtCswYDJMo9sxiEwIJCFYYiKqrv22eyUvpxpgeLQVWY5RJ9QaIluzNmccZhBQW3Jr9mCf8UNSUOxd1xz5FA5vh/dKgNVW5p/Uft84n3r1K/p7t2CGuAnEfiHF16YbUo4ZoeV8U6i9zoIaFpMJO3QFy4zoY0jtYVd4OF51IDSmVlsI7VrX4JTyZi8ZUzSEMwcNDGXVxCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5CB8N4PV7ehqOJApdMpGgWjkZjb9zz36rGlBonAyfA=;
 b=WlR2O+wQZvOyC1IYmMofIbmDZUHT0Sf6noOX0tw5qQRFVjqW75A27TJYFsXUb/kQKlxcLRPgU39dpDc8uRNN72Ka5xg8MSOcr1xDHeuxSaDz9oJmypvpYgrGmOSYAP9c8AqvbKJMK45H66xXkmlu8VVEg9IxfewUOaD6g22mMJbmNjNpDPLZgU+ulRdkGSicRoyoy1X9Jb7znh9dt+mPvajGWYCoyIoEi/cAvwb2l9DdsSMIzOZhsIC8TC9IX1X9PY8P4cm7NkbdWKXamIXhKRdorAYwiE3Bbm4nlX6liN19Oi2lN32Xcw4JiIN+V7zi4FhfRINjFCKVmKngQg5KKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5CB8N4PV7ehqOJApdMpGgWjkZjb9zz36rGlBonAyfA=;
 b=aC56TONbx/tnwSpA4zSthNlF5MI3NjVmuUYqukiL44Uf1Uyb2NyVLZlu+o/5iwOy+onQa4aMEzfVHAV5LE9ROr7Sf05mXS529+CEC4MtSuS9UqwHdReMyJEUyOfKBrCksitIrhv/XQw8YtcefAJMI/5SZqhP4EuXd6OTAh5fmAsdOhq9xPr8hkkWT+8KuTKGqTF1EYKh4e98EeC+FNP42lrgKUO508wBsPAHQS3ZEzsdlKM7pjqPsT/QIkHtC7sfZCneiWBWs2+pznO5S1Yb+974GZgFjtfR4rU+VUiUcLUYmr9JUKxVr4qN49d1rKMZYyig2MLYRHTpE986PviT4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 08:39:18 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 08:39:18 +0000
Date: Fri, 3 Jul 2026 16:39:11 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Alejandro Lucero <alucerop@amd.com>, 
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
Message-ID: <akd0QZYk9zy4d7T6@MWDK4CY14F>
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
 <aimmfgWS6IPtwLVA@aschofie-mobl2.lan>
 <CAE+C+DYnidq7ZFoyxeL54YCT=JF5-Q-NkGFTgoAaW9EztwwaGQ@mail.gmail.com>
 <akOLH861twsGqEFM@MWDK4CY14F>
 <CAE+C+DZhgBRYPctfMO8m7uBVRmqTVs3YD0GSpOGQZ535+eOAwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+C+DZhgBRYPctfMO8m7uBVRmqTVs3YD0GSpOGQZ535+eOAwQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6154c0-9585-4e53-ec9a-08ded8de9218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u5ArOZtYE0OPnYOB7VxS1QvWHNWK2VvFoacjTuyi0Pn5Jzdj9XU4RdsMBozjuEAyHoCkAR/MdYRSnrTf9pPLArfw9z5ISlqdv+gt51Bnjy1d6uDvIglcN7jLXHf0psKAGl7dvSCSz+SM8Jv28dPU/BfAS3LZnYXYDSBDzi9axMqHcICXN50JR3FexKcjM+j5NycP7UoKFva0et1TmmFN2+0WHRUrvOmx075mfAX5eTfd2WhoTr3pyA4SQeyC8L2tkH/5/kohpBNN7ghQqq6DxfZCEIX2veJppw8PHt+00XvK1FWhRWBGJGntQJE4RgmXA/ztf5F+n1S1aDW8u7CzyQ8JuWmGdUpl0gqTYiLGYBSTE/0cnsIwDzgpLG+mq1Fljp6AdfZ8DwJNtQX5v02fyAqdHF4thhWe6a2yFKnDIORblpRlYll6Rbp3Q5HfUfYgmuIRbsG860jv8bNaB6CNgB8HZYS3ijvMwR9vhx91d2UYkWTX6ucjwGCX+tTKlLcfV8WO20JOsibss2iiXbcpmJeK94VijqD6NcDjWn9t7UTSkoDQGcK6bhSn+Jr3+kR/jiMva3ZSC+1mTaTDlKTCj6vICZ/wq1mFkDvgczWIFnmfFV7JAKEgDW4R2fX5cua7qA1uQUvrWQtOWCmlSC7mUFZujfMqNABI29hHN7ctoUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJoblFBV1lTUU5EYXRKaXoxQUxzR2U0VEV1R01vc2ZNMzFia1dvem1sVEUv?=
 =?utf-8?B?MTU3aEpuN1RkQlFzWGJQbXhqaktnVHNPQ1BHVTZLNWdIaHlTVDJlaGVxT1kw?=
 =?utf-8?B?djVlU2pjNDluL3JlUGw4U3hPR3RIQjNJSE41SjZBUGd2SVlrSjBMdHlGSzhY?=
 =?utf-8?B?MlE1OS8rK1FId1Vpc3FVbmdERVV5c1BEaVVGOWhQSGtBL1BRRldVTFA2NzZs?=
 =?utf-8?B?WVZMOHN2QVpuTUowbUZWajMvWmJWVXlGY3lWb0F4OC9VdVkxeHladnQzZFFj?=
 =?utf-8?B?ZzVNRjhvV0pSNFhJd1RBMTJ2UUJwYTZpbldya3NJTENDWTNhZ2ZmOCtBMUdJ?=
 =?utf-8?B?bzByOVU5TjhONDhoWS8wd25WdkUrM1Zad3Y1QWI0NFpJNmplaGhueDRmKzFS?=
 =?utf-8?B?M1hkVlRyY1Q2Q2Z2Q2hTZ0RLT1huelM4UE85a2lrSERrdXBtUEM4OU42WHBO?=
 =?utf-8?B?c3JCcTJManVuaGlhM2l3anpkMnk5RUJZd3AxcHRrNDhwTm5abW9pcFdWbmJk?=
 =?utf-8?B?OEtJbXhZY1VFbDFyYmNTeGxTVGNWbU8vOWRpb2ErYVNFUjdldGdVdWtLT1ZS?=
 =?utf-8?B?c1U0WWZvU1I4SzVnUVZzSk80THNJbTMrVVBDYk9nRDFRZ3hxVWdrczdFYk9U?=
 =?utf-8?B?dENvNSt0Vlpxa2l5b1lDbEE3Q2pEc1dCUHdUd2FQb2YzUjN0aU5NNTR5Slg1?=
 =?utf-8?B?MUsyWEFySkJlcERiYUlvLzYwSHliTjRSNTlYbm5QcCtSMGpKWllRWitFa0xt?=
 =?utf-8?B?U0pka0tsakErR3YwVmloREMzYVJGenBhMjA4Ti85SXd0cThUS3lrcVJ6cjZj?=
 =?utf-8?B?alVMUGlaSzF0Yng5MDRCSXVrT2k2OVIrSmg3TmVFbEpNQ2N5bSt2Q3VPMmRv?=
 =?utf-8?B?MXFWUWhtWVcvMnlZMXdMdjIvTGJoWDlURE4zVnNFL096K002VHFSazdWSVBr?=
 =?utf-8?B?Q082eUFXZjJJRFpEOCtqMTMvNDNOTW84eFNRbFQ0MlJyQTBoM1hIZk4wRloz?=
 =?utf-8?B?OG92U1dJdWUvczBXOFFLVFBwanBWUXBmeHdQV0NXbERwUnVUQWJ1WENhUGxr?=
 =?utf-8?B?Q200U2ZpNU9GMlVGSGJBQTgwNUJjWEFOR2dZU1ZpUkM2UnFVRlZrdDArVmQ4?=
 =?utf-8?B?d2ozTlJheEhFWitTZXczZDRBUlY3MUxBMExsdlc4cG1iS3hjaTE5dzRaWG1y?=
 =?utf-8?B?cjdkMXkwcndDY2xnSk82NkhHUExrZ1ppdDNqbDJXdWRsd0N2MzJyaG9vMWJv?=
 =?utf-8?B?NkVGNDZEUytESEh0cktsZUZGUUhycDF3eVR5aXJwM1lYbkZUTWlhWHhQcTBN?=
 =?utf-8?B?R2tTNDBBclpJZnFTVWl5ZHEvNCtvTmtLT0ltWE00Vy8vMHZ5eHgvTXA5dG5H?=
 =?utf-8?B?ZTZ3ckZJOGNFY0diM1hackwxYk1scUV3bkhOOFNCQUhqVXM0VmVXaVRFSGFF?=
 =?utf-8?B?dDU4YnJ1eG5LeDA5clUwS21ySHhpN2RVNnRXZUcrMjJFVk5Zd3A1emRvdW0x?=
 =?utf-8?B?aE1CUmZ0UXNXSnVzemhqd2pQeHBYYUVEQTdmb3Bka1FJQVpoMmJTT1RYVHpi?=
 =?utf-8?B?WGF6V1BtNkR6amNHbHhwVXR4MmVvSjEzTmsxWWUzbnZjUWhodlR2dUl4Tm54?=
 =?utf-8?B?SWVBNGd5a3BHQ1FGVHNkRkV1NGJXdkFxWmtadnBPVWZQelYwNHpRaFNjTW02?=
 =?utf-8?B?L0o2Y3RWR2ZxYzNXalhNaDRDMkJnclM4b1lmajA3WmU2Z0k4WmNxQlE0eGFV?=
 =?utf-8?B?UXFLUjMwZVo1TTRRWlprQS85c1RKaUR6QXRJUFNLTjhXZkJiR1ZhRVNDelM3?=
 =?utf-8?B?Z2F1TkIrVFhxNHliVm9DdGtzcEZKdHZtY0pmc3YxUkZJUWs5dWgySHhmSHQy?=
 =?utf-8?B?aklNRFA4cnY2ak5SMHV4d3V1aXFySHQxa1JyYkJsZzNKdVZpdzFFT0xnK1Zo?=
 =?utf-8?B?VnpwbStkR2NmR1Q4Qzg4QnRJT08yeWtaR243RURRY3pNYy9YdlBueVJCL1p4?=
 =?utf-8?B?Z0pUYTkrVXhDbXFxRTFQa0t0NlFIMnQ4SEpZb0tRL3RSdDJHZU96dmIvT2Jr?=
 =?utf-8?B?cGVrUEVUUnhLTlI5RUlPNUdlSzNoZ3NWYnFTMkVielFnbHFpMjhHZVZUeW5W?=
 =?utf-8?B?SWU3TEtKOHFwY3gySlc4M3pHU0ltOVEzZ3NMSExKSXJMZVRzQktYNXVLdjRu?=
 =?utf-8?B?Yzg5ZEZIMTNOL0tPZmsvaWlhY2FPNS9tMGtYQzJzOTdpeGlKR2JDc0VJYTk1?=
 =?utf-8?B?eHVQa29OS0lnMXhoSTN3T241OWdsQ1RpbGI4bGRVUk5JZndHY3RMd3AvekJs?=
 =?utf-8?Q?0jfR6VpK045DaXwvrL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6154c0-9585-4e53-ec9a-08ded8de9218
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:39:18.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWHOzAJUMaGqyogEDUgFeOhryMTqgA9461+KOWrWKV8Js6cTrsPvBOMhvEFmvgHgNwPD41l8Ueqty7RP5HJfng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524

On Wed, Jul 01, 2026 at 08:38:54PM +0800, Samuel Moelius wrote:
> On Tue, Jun 30, 2026 at 5:27 AM Richard Cheng <icheng@nvidia.com> wrote:
> >
> > On Sun, Jun 28, 2026 at 11:45:29AM +0800, Samuel Moelius wrote:
> > > On Wed, Jun 10, 2026 at 2:01 PM Alison Schofield
> > > <alison.schofield@intel.com> wrote:
> > > >
> > > > On Fri, Jun 05, 2026 at 02:20:31PM +0000, Samuel Moelius wrote:
> > > > > The CXL mock mailbox GET_LOG handler validates the requested CEL slice
> > > > > with `offset + length > sizeof(mock_cel)`.  Both fields come from the
> > > > > userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
> > > > > offset near U32_MAX can wrap the addition to a small value and pass the
> > > > > bounds check.
> > > > >
> > > > > The wrapped request then uses the original large offset as the source
> > > > > address for memcpy(), reading far outside the mock CEL array.
> > > > >
> > > > > Validate the offset first and compare the length against the remaining
> > > > > CEL size so the check cannot wrap.
> > > > >
> > > > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > > >
> > > > Hi Samuel,
> > > >
> > > > I'd suggest keeping the commit log focused on the broken property and
> > > > how the fix restores it, rather than tracing the individual arithmetic
> > > > operations and later accesses, which are already evident from the code.
> > > >
> > > > The GET_LOG handler is intended to reject requests that describe a CEL
> > > > range extending beyond the available data. The current validation can
> > > > incorrectly accept some malformed requests because of arithmetic
> > > > wraparound, and the fix restores that property by validating the
> > > > requested range in a way that cannot overflow.
> > > >
> > > > The discussion of the subsequent memcpy() access leaves me wondering
> > > > what the observable effect actually is. Does this return bogus CEL
> > > > data, trigger KASAN, crash the test module, or something else? If there
> > > > is a demonstrated failure, please describe it. Otherwise, I think the
> > > > property being restored is the more important aspect to capture in the
> > > > commit log.
> > >
> > > A longer explanation appears below, but the bug can cause the kernel
> > > to panic with an out-of-bounds copy. So highlight that fact in the
> > > commit message?
> > >
> > > ---
> > >
> > > The bug was validated with a PoC that deliberately invalidates the CXL
> > > mailbox GET_LOG command to the mock CXL memory device.
> > >
> > > The vulnerable code checked the requested log slice like this:
> > >
> > >   if (offset + length > sizeof(mock_cel))
> > >   return -EINVAL;
> > >
> > > Both offset and length are 32-bit fields supplied by userspace. The PoC sets:
> > >
> > >   in.offset = UINT32_MAX;
> > >   in.length = 1;
> > >
> > > So the vulnerable expression wraps:
> > >
> > >   UINT32_MAX + 1 == 0
> > >
> > > That makes the range check pass, because 0 > sizeof(mock_cel) is false.
> > >
> > > After that, the mock GET_LOG handler still uses the original huge offset:
> > >
> > >   memcpy(cmd->payload_out, data + offset, length);
> > >
> > > So it tries to copy 1 byte from far past the mock CEL buffer. In QEMU
> > > pre-fix, that caused a kernel page fault in memcpy_orig, through
> > > cxl_mock_mbox_send, and then a panic because the test kernel used
> > > oops=panic.
> > >
> >
> > Hi Samuel,
> >
> > The substrction range check looks right to me, it also matches the existing mock
> > LSA checks.
> >
> > I would suggest a small regression test if you have time for it.
> > Now in-mind only a pseudo-code version, maybe something like that following
> >
> > """
> > /* Use a cxl_test memdev and the valid CEL UUID/advertised CEL size. */
> > ASSERT_EQ(send_get_log(fd, cel_uuid, UINT32_MAX, 1, out, 1), -EINVAL);
> >
> > /* Preserve valid boundaries. */
> > ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size - 1, 1, out, 1), 0);
> > ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size, 0, NULL, 0), 0);
> > """
> >
> > The first case captures the overflow regression, the latter 2 document the
> > intended inclusive end-of-buffer behavior.
> >
> > What do you think ?
> 
> Could you please give me some more specifics of the type of test you
> imagine? For example, should it be a completely new test? Or should it
> build on some existing CXL test?

Hi Samuel,

I'm thinking about adding it on ndctl's test/cxl-mbox.c . It already opens
/dev/cxl/<memdev> and issues raw CXL_MEM_SEND_COMMAND against the cxl_test.

Something like the following

"""
    /* struct cxl_mbox_get_log: uuid[16] + __le32 offset + __le32 length */
    struct get_log_in {
            __u8  uuid[16];
            __le32 offset;
            __le32 length;
    } __attribute__((packed));

    /* CEL UUID da9c0b5-bf41-4b78-8f79-96b1623b3f17, GUID byte order */
    static const __u8 cel_uuid[16] = {
            0xb5,0xc0,0xa9,0x0d, 0x41,0xbf, 0x78,0x4b,
            0x8f,0x79, 0x96,0xb1,0x62,0x3b,0x3f,0x17,
    };

    struct get_log_in in = { .offset = cpu_to_le32(0xffffffffU),
                             .length = cpu_to_le32(1) };
    memcpy(in.uuid, cel_uuid, sizeof(in.uuid));

    struct cxl_send_command c = {
            .id = CXL_MEM_COMMAND_ID_GET_LOG,
            .in  = { .size = sizeof(in), .payload = (__u64)(uintptr_t)&in },
            .out = { .size = 1,          .payload = (__u64)(uintptr_t)out },
    };
    rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &c);
    /* Pre-fix: offset+length wraps to 0, passes the bounds check, and the
     * mock memcpy()s from data + 0xffffffff -> OOB read / panic.
     * Post-fix: reject. Assert the request is refused. */
    ASSERT(rc < 0 || c.retval != 0);   /* mock returns -EINVAL -> retval set */
"""

This is draft by my claude-code, I haven't test it yet, but the idea seems
correct.
Note that the UUID has to be the valid CEL UUID.

I'm happy to send thest test as a follow-up ndctl patch on top of your fix, or
you would prefer to fold it in, whichever you like.

--Richard
