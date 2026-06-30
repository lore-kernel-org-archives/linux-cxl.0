Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1003E92AC;
	Tue, 30 Jun 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811664; cv=fail; b=lt6Qm9f9Ftlh3NLXWp62GbVsshpecbDN2nJo1+cD/7R1VijaAy1bQil5IPuEv1HvYVrQ6AoilYSBFjCicspWob7aIbCI9l2atrci5nKb/dUknDK2y3IQiJ+UCVw1U0SmsmYCq0JHLn6Zui+CzjkpbjaEnQ0prRIg5qDU4ugC8ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811664; c=relaxed/simple;
	bh=ksnekUj0m/dpSS1XPxCq8QYgeYYiOn1vm/BgTowslOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ny+YWKGt21ieaskasyJglHgEHaSYqx4KV3E6acHHxlplBpiZ+CAfTD0/yRBbR+3/FDV15vfjKGxG7QtrUyFVEiELLJJRIsTToTD9J4tsXvQ8mtHNnBE7rPd0BWPTeDCapjemXVZOfk4v7NQ6u9JMcNOwY5FI57tv7xxjLVGupJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LnbdATPn; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LnbdATPn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpdSWusxho//T6g36XO1zwaWZeuD0mcbR7ItJeXcVA8s9HUQTNAZ4itI/p++/Qw90zf/OhuiCfq2UYHtgiVhZ6KTlvwJilReDHPi1gy2EL9uitQnD+pqZuf0NDk8ct2N/fgTTDVfakXjW5XfOJhYGZ8skL6m4reBbktu2WOBoX+KO2vytIZdLNouQkG/goUhGUCGh8PemELSFThHq93LsWpX3SE3dWc5SIdqaWBbURsP5juzgZQO82UPAj6iWq1AFNRpgPH9Z8mRPJNkXcYJtiCgwqyQnJU9l6Z3rTfCWYA4HY2omPI42yr3SlLRKp93/N2WRgmRBT9iVc9PLBG2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nMpcyJQTisbWdDlomUqIIlkgmj9OJF1SSlmKMt4L4c=;
 b=XboFCpDMfksLnX2MIpOLkjFh9pZpZWAJwq57JxUPSEQoP8zU9U1/ujSX/xnckSCeLyweQ1VCcjTEIPpxfsf1y07CNJWs2ICmnIC2aSHN6A9Vkzpyp+mxLLv9iKs1F+JRXXNywBFpNPajZyfh3ftfQq6shYLYCL21z4/3Jz1PIillc8TtNP3/fK8PnT5QD8RQPIe2fsJzaRj5RdupjhZQws4aIrVfE+vLF0P5kRXyaLkE8UfhztlZHitSRE/APvpvXftDE8bXr3G/ejbWYm5F2IeDps7Ur9Ju5McdFFq7Wze5ZO/6/JPqGGUHtRIEnG75jWrboTjMATFvqBHwkbIwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nMpcyJQTisbWdDlomUqIIlkgmj9OJF1SSlmKMt4L4c=;
 b=LnbdATPn3UASCmCVpGjkp1za+KqAMfaR77tbhOg0ksn4KqN01sYSr0Dy5zEREzUJ0SPqttGi/L9v6PNm68TtwB6mzUG+PA5y5oEVwNctULZ7f9P8RPKngYzICWB9lJDBNDra0IvFzYhGXIj4NKTC25U5Ix8De4xOHmQ111s6ZKTdsiBoNICUwr6oMDPJhOaeMTXzMXQds58HVF7K42zdmfXK0eLATSLx3wBeELzS28k5xpxLCsjjOnIbNYGbk+56qL2zdZlfZAL6Dalij7c5mzaopt5u48RiQf3PevnE8j1uWmMaFXlMYL+nf6ZtaFpybgN1jFt3/0ysFOitQJIINw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 09:27:38 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 09:27:38 +0000
Date: Tue, 30 Jun 2026 17:27:31 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Alejandro Lucero <alucerop@amd.com>, 
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
Message-ID: <akOLH861twsGqEFM@MWDK4CY14F>
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
 <aimmfgWS6IPtwLVA@aschofie-mobl2.lan>
 <CAE+C+DYnidq7ZFoyxeL54YCT=JF5-Q-NkGFTgoAaW9EztwwaGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+C+DYnidq7ZFoyxeL54YCT=JF5-Q-NkGFTgoAaW9EztwwaGQ@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: d334c579-df89-4501-e15f-08ded689d360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tUt+Q6W+3S+zg6yp8g4o7+fQTMvfXrrmYOlFUOzgfgwRnVRJOmQxcXn0/2kxYjiF4c5dfetU2QhMPukaXuB7/hWmG8wFRDgISyeGNQNrZCsNiBIwQUmprs4mQvpwhqfhrNMdAw4tY/64fuis5V2FRARwgdCW4SAV+cz0mYGdX/BisijXkDPY3cbqJ5tnvtK2C7zLsQkM3eUWSDddLXnxnbBDq6f6vyLtaSam2FGQt2uVpMzsEEQS7lKX1zg/muEbbniXMSHagUj92Wpu3sDmDXfLnliJdwKgnp6iicjAEOQHQEf+2uKvdAsYM2e4qoSkPlBUYo+PZD2jUvidNXlOwmuV6RlqAU0bDH3nJk53E2ckwL9w8mQSKuFGOtrQQIuQckl1/sz++I8SMICQsiIhTbUmppafKifBfSXaH+OE4qzYV298c8ED2Zu3qp7pgMxSqTA2UubgT5l9SlP9iAeN3bb44fZJbecbor3qRnzYAU6HRcsOUMMTftYmo4viBQGIEbDQ40vf+fE8bvLrnsSBVItyYXCpHNgIccug2tWBfdCt+COtkKfkIvyAZ2+eKIlNACECUoodOqyYDAgvEQeL1kPXy3r3IWOuh3aBfVZPuavD1O4VTszANdmCMQbVHHUdS1UQlCNMw1/q9cEW6NT8DMux1tzsa00ocIDvlRv/UHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlNQeTg1U3BNQzVuOEZqdisvbnVkemZQbW9ON3dOa01aRkVYcDQ5cDgxV0hi?=
 =?utf-8?B?S3drWmo3QmxPZjQvTVBuNFlvMXp0aGZRZ3k2UmtUR3c4ei8ybmd5eVlwZTdr?=
 =?utf-8?B?cUlGSWcwdTBQY2hWNFo3ZEU3N2tCME9LRi9JMGJXMjR5WHIwQUtUKzRGWDBL?=
 =?utf-8?B?MUZKRDlzSmx5Mm5vZ215OUFkdUMzUUVFWnMyWER2UzFqNldIN1Zxb1BOcmVy?=
 =?utf-8?B?UWNUVGZBMjBpRmNiMU1veUNHUUxSNW1VamVjZ1ppZjcwR0llV0E5UW5iOFZj?=
 =?utf-8?B?WmxiWUt3T25Pb0dNTFRNVDBUakZmVXBLeHl6eVFudEp5UGlIK09wOVZoRUVq?=
 =?utf-8?B?SjB6dlJMM0J5ZmduODZRQUdQRFlUSmd0NUhEQ3RrSy8xUjdoM3ZRdi9DRGtD?=
 =?utf-8?B?UXlhRzhFbmhWakJtbmwweGRqeVgyN2h6SGRLMDE2YnVBVzZLanpBQndRTWZK?=
 =?utf-8?B?OGg3dTBWMXV6QzJwZHdFSEpqWE9PdTYxSzlyekZOWFFPajRUeU1RaG5lWlJm?=
 =?utf-8?B?RHJ4cC9MazhFQzQrWUpOVWlNTHVWRzlGOWdnVUc1K2VISjFLNUNXSGpUNTB0?=
 =?utf-8?B?b2tqb1phYVFhTVFGekFubUtWV2pmRXJtNUZrQ2JjRVZTNUVoVmErUW9LT0Ji?=
 =?utf-8?B?UnZ0cWhNemhBNTgxU3lKZ1FKN1Nrczl6V25TWE1PUmRhKytrWEZWVzhxV2pU?=
 =?utf-8?B?enphSnd5ZzRCM3Iwd0Z4UzAxZWcxS2R4S2lZTzJkb3ZRSzJpbmx5TjJkaDBJ?=
 =?utf-8?B?djFhU1VHeXJ1UkRDc2xnWE1BZFkzN01VTE9RS2o5TC80TmMrSVMzb3hNa3dz?=
 =?utf-8?B?V3RnS1dMVG5ZTllaTVBHRDhoamlVSUE3eThsRDUvSWV6dkZEN2ljU0V1QlUx?=
 =?utf-8?B?NVlPY1RWU0VxSjc1NVBzWXlpeG9NaWQ5UCtMNmp6VmdUZVJYdTVxaUtLWk5x?=
 =?utf-8?B?a1ArMTkwRCtxTVBtUEFialJQNkpWdHRyNFBMRno0MHFicjhUc1NCRzBkODJy?=
 =?utf-8?B?RlNvMEFmZ3AxcGNlN3p4dEppSU5xNUVmYlVZb2xQZlZKWG1DSWtVblZoL3Bl?=
 =?utf-8?B?MGVMR05rSi9Ybkl2cWE1THA1U29BU3JHemp6UVRBdElWYUFsZHFpVTZ4bURa?=
 =?utf-8?B?cW0xdVNRVUw2MGtHTi9IWUFiMmRDbER6akpiV0xYeVpmWkhSWFlyN3JIWG01?=
 =?utf-8?B?NGVVdzBuY1hlT1NKS3F0NlRXR1V5cStZWlBKWis3T0sxb2V3UVZTWGVHY0Z6?=
 =?utf-8?B?RmdMb3Y3RDBHNTZERnpaYVhyZ2dqU0hGTU9HVG8zcE95cWVXVURreldtVzhS?=
 =?utf-8?B?NU4rR3Ruc0VBc0xGYXdvQWhablUyNHJKYlRtRHdkSnVhOUhISENocnNrcVN5?=
 =?utf-8?B?MkRzM0ZKQjlKVHo0SnFtZXh2YTVXZy8vVThwdUFtdnFQM0JEYWJ1RjZvWW9u?=
 =?utf-8?B?dHpEMkZzSFNjdXZ2MmgvTTVwNmRiVmtwSjVLd2Y2bGZBa3RuWDF1QTk2cllX?=
 =?utf-8?B?bFF0enVPUDdBc01SNDg4OVZpWStua2M1RnhiaUFTQTJSb2lIbEtkUzVIYk53?=
 =?utf-8?B?K3ZEY2tnOWVtSVEvYUlHOHZ5ckhLNEJLNkhubEgycE9sdWliMExtQ0svZ1h4?=
 =?utf-8?B?ZVhMSjZUVE1TT2lTQ3Rod1pCWXlBOW5mWFJqbWM4c1drNzMxRmQwYldpamdz?=
 =?utf-8?B?QmpiQ1JCdHA3TklGeW1FZFozeVNBN1hzMUZGNWQvenhoTFZUMDRsMU5udkJu?=
 =?utf-8?B?V1VxVEM4cnhLVWNpUUhGUGUxNS84SzVrTlFzMWgrUkduQzd2czhKdmE2cTgv?=
 =?utf-8?B?MFpWWVU4RXF3TkJuWG5YQ3JTUi96RDA0NVJiQm9pdHQ5YkZIczVyU2ZsL044?=
 =?utf-8?B?K3NpNUd5NmlpNGxEZ0Q5OXdOQnNqWkk4ME5YbGNFWVJzNnFZVm0vcTNsYXNn?=
 =?utf-8?B?SWlvRVZOcjVSMlZoMSsvSlBkTjB0WCtCNHh5RHBOZ3lzN3Y0YmNFSjJMVjlM?=
 =?utf-8?B?RldKN3p5T0NQWWVPR3h5bit1N05OamdTaEV2QU1YcTBpNnRCNzRIeGpYWUJH?=
 =?utf-8?B?Wlh4b2pjOE54TzBGT1FoVmxNT2J0eXpEbUhQL3BmdDlaNFN1aFhzdk04WVBN?=
 =?utf-8?B?bURueUFCYXBVTE9YOGNNQjdoYTJHTGZNSE4zTWpzdEh4SUFzWVpIa3RoRXRU?=
 =?utf-8?B?OGZpVGdpMU5mSlR4QjluVXVjajA1R2txaVV6RFVZUTJBK3NkNm1hWUd5d0Ev?=
 =?utf-8?B?VjE5czcwRXVCc0tzcWJrcDFCT0trUDl5a0x2U2JQZUVSc095UzNadWs3eVFp?=
 =?utf-8?Q?GgKob251nj6uc0pLzZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d334c579-df89-4501-e15f-08ded689d360
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 09:27:38.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDQgzNh0Fvc12EjwRl/M35Y1hJ078eRM7oSr1wkAGHbtczFACJxrJyWG0dWdnCf44wpqcH1/Dc14Kg0Xp/L0/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

On Sun, Jun 28, 2026 at 11:45:29AM +0800, Samuel Moelius wrote:
> On Wed, Jun 10, 2026 at 2:01 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >
> > On Fri, Jun 05, 2026 at 02:20:31PM +0000, Samuel Moelius wrote:
> > > The CXL mock mailbox GET_LOG handler validates the requested CEL slice
> > > with `offset + length > sizeof(mock_cel)`.  Both fields come from the
> > > userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
> > > offset near U32_MAX can wrap the addition to a small value and pass the
> > > bounds check.
> > >
> > > The wrapped request then uses the original large offset as the source
> > > address for memcpy(), reading far outside the mock CEL array.
> > >
> > > Validate the offset first and compare the length against the remaining
> > > CEL size so the check cannot wrap.
> > >
> > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> >
> > Hi Samuel,
> >
> > I'd suggest keeping the commit log focused on the broken property and
> > how the fix restores it, rather than tracing the individual arithmetic
> > operations and later accesses, which are already evident from the code.
> >
> > The GET_LOG handler is intended to reject requests that describe a CEL
> > range extending beyond the available data. The current validation can
> > incorrectly accept some malformed requests because of arithmetic
> > wraparound, and the fix restores that property by validating the
> > requested range in a way that cannot overflow.
> >
> > The discussion of the subsequent memcpy() access leaves me wondering
> > what the observable effect actually is. Does this return bogus CEL
> > data, trigger KASAN, crash the test module, or something else? If there
> > is a demonstrated failure, please describe it. Otherwise, I think the
> > property being restored is the more important aspect to capture in the
> > commit log.
> 
> A longer explanation appears below, but the bug can cause the kernel
> to panic with an out-of-bounds copy. So highlight that fact in the
> commit message?
> 
> ---
> 
> The bug was validated with a PoC that deliberately invalidates the CXL
> mailbox GET_LOG command to the mock CXL memory device.
> 
> The vulnerable code checked the requested log slice like this:
> 
>   if (offset + length > sizeof(mock_cel))
>   return -EINVAL;
> 
> Both offset and length are 32-bit fields supplied by userspace. The PoC sets:
> 
>   in.offset = UINT32_MAX;
>   in.length = 1;
> 
> So the vulnerable expression wraps:
> 
>   UINT32_MAX + 1 == 0
> 
> That makes the range check pass, because 0 > sizeof(mock_cel) is false.
> 
> After that, the mock GET_LOG handler still uses the original huge offset:
> 
>   memcpy(cmd->payload_out, data + offset, length);
> 
> So it tries to copy 1 byte from far past the mock CEL buffer. In QEMU
> pre-fix, that caused a kernel page fault in memcpy_orig, through
> cxl_mock_mbox_send, and then a panic because the test kernel used
> oops=panic.
>

Hi Samuel,

The substrction range check looks right to me, it also matches the existing mock
LSA checks.

I would suggest a small regression test if you have time for it.
Now in-mind only a pseudo-code version, maybe something like that following

"""
/* Use a cxl_test memdev and the valid CEL UUID/advertised CEL size. */
ASSERT_EQ(send_get_log(fd, cel_uuid, UINT32_MAX, 1, out, 1), -EINVAL);

/* Preserve valid boundaries. */
ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size - 1, 1, out, 1), 0);
ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size, 0, NULL, 0), 0);
"""

The first case captures the overflow regression, the latter 2 document the
intended inclusive end-of-buffer behavior.

What do you think ?

Best regards,
Richard Cheng. 
