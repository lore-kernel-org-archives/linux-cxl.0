Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D224382F1C;
	Thu, 27 Aug 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823269; cv=fail; b=hnYAseo2ieDb+/RjVBZq4yXdBiDbGzlUvVWx1GTUvN8H+RnT17s3IPLV3SURr+26wfPOKfICnImV/SdvCsvUDkzn90cGvBlHGDgQgs3Nbbgfvk8Lo6r1xihrhEiAvdCg93IzBqvbgwtkJTZhhWBdCgf7l4KzeFG6cH3J77CcYBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823269; c=relaxed/simple;
	bh=bKBFg3LdfwgZcUDZwtJNTCqvNdRfWXXRKNnxEDEX1CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MwusEOe6gHaAeAV75715+b2q2fGSmH0ev9sNu8Gjw5xy4EEXDN279YWSMq56xa+4Zs1iD64klx2e04OdqUFfmrvVuIVU8u3rm5SykWxleXqe+frH1yOMzQoGz7xb22ECa6lWp7+tsIOQP3PYVOpF9L+b4pT8oXM9k/4QS+45LPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFQuHzli reason="signature verification failed"; arc=fail smtp.client-ip=52.101.48.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFQuHzli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQDOZ4ZrQwIUoLZwcu/G8b2B9+OqScp4jpzSIzqfWtcOYr3govDVWzUZkwRpHT7pMeUpS5KrzjbflLD8GobnY1Na+qRmQ0wMH7nUGkPk6uyq+lZJm18y7E0iTL4EpZoAm7VcynSx501lcxGpQogAOxtKqfbkamy+psfzBSuUWq4nlbTpassyEXgeQQzE0jweGtac9Wyr+zBg7CAzIiQbtmxXrk9ZFleMYci0bCpsFHYEPOoab90XnOPYeKxCM42KBZUpmffeGzSBAgaejTnG4uXZxNfk9WpZSWnG8IU+z8N19CCmn0eUg3tK3gcyjBx9nqaEHx9aEPQU86hO6a9+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t5/UzOglFpjbl5XhNykvNrmoE9YNXjjQqJcuiDYXOU=;
 b=bDx/55Yi1htxVeRhR8XxSEDTn75n7D8lmoItC0SKrcvgWU+PWyeBMUjCz8hTQcKeWl85vZJcVmkiLeOP/qb4q3S2NR8Tut3zEtuz2R4abd1gk8VHPIwBXh6kmKCFK6cMIWqSzXDRT0DqkgyGl1qhhQ/P6RQESrfl+Fe0aqKrbtWOpN9rniDet8MiCltmx/BDv8wfXO02nEB/hyarUYBle2zR2FRCCQcg6h4gkbLNXgONVsaYh0HMX56iLC86Q79LZ6LbmzAZOYFQIaTIvswdR4dJHwOub4TN1KQlLcDUUZ9x0YgZ6/ebEiu0AAp+Fv7QuG7js6tAIAVqNR+vVXjQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t5/UzOglFpjbl5XhNykvNrmoE9YNXjjQqJcuiDYXOU=;
 b=cFQuHzliwWWdjkbGSh6RKd2edcYjuRTeDprWLRLHfdOGP0YYu5cW2jpOT4vUZM9GgMmiLZWl3tOxLIRyjiFZICt9Y8Cn04TPsjaQRDXj8Pk/e3HwORr45jenfEkKwoM0Qi8A1MStNXBwDn7wELsLaidH63D8kr85r09Uex3Myco6sk/hTvWxynnZpqXWPd28EsgbHDU8i1lrYsUIbo8f93HqjDJeAnF1Iy55Mlk4yxOFbQLj7bLVqLygtpEbFSmZOb4kBl19rv6bdKiTceOEAGyK/0yluY9StAhMch59V6tnOr65Sc/6WC1VIS5RNq67GG66ELBR8wh1uwooZe1Mxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 09:34:04 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 09:34:03 +0000
Date: Thu, 27 Aug 2026 17:33:56 +0800
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org, dave@stgolabs.net, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, 
	alison.schofield@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kaihengf@nvidia.com, 
	kobak@nvidia.com, vaslot@nvidia.com, mochs@nvidia.com, newtonl@nvidia.com, 
	kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/3] Support zero-sized HDM decoders
Message-ID: <apAEWBVOUJW7kJ9b@MWDK4CY14F>
References: <20260805055524.22311-1-icheng@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805055524.22311-1-icheng@nvidia.com>
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a07f94-3c61-4125-70fa-08df041e5523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|11063799006|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wAAqgia7u/XOHzCrudl8gJoRhSjJa1gE4arSvUhtzjdTYElV0GSImc08/8nue4H+bqsDzI1YECGviMnbAFs82ng/O3YhIM0RQPOU+GtaIWGOZv8eLj+gf4+utRVW/xOYhkMAdLlZYP5JnnR44KV0rCV/X8tmHjcQ1dCJKfIPGhCV0a/N+/w/MS7k4kWCS27tEPAKtxNbdiLF+lZiAXukJeNtzrjhbMT1JN23glr8FqZHlXyuFf85oVf6VXyqUm+mQdUycyr7nZZmgzUHDAtWcgryuy3TKMXZt4Je4nHAn5hFCZl2uWxzFP0ZuF6byDWyhkQWcZ3gyMkToeRiqCrXhUrfDvrZ780hDD7+NTWh38V0xT7KwRf3gO1otMS0SY11RvWuWm4vX823PnRjd579GDkvRAWqpQXUZT7kss00dw9fXVjfM3rs+s6Tn3RiXkXC8Djkd40CUeLe4Ex7WgOS293aUjUysCh55xRqrX5YTmVAj9acwtiPG+1Lfxbm1wYlPjVeik5FLvQhXoY0CNAg6jpVFnB7ni2YAtQzh4STSzjo3gosTa2qK3d69gRCK3UyhflpA0fRcKV954CbKquvowOiwlbAvY/9NxQbTTR3cZZfLrzJrUHrTRcEw/PWVCnKQklKILksrSkfNFOBwA3WJFG/o+3g1WG5NsvX0ynsaIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?K+9vkrg6sqotO6JMqzMv2PggTPZgt9OJbnivEvbQAfI2JdAZRFbZtN6/fd?=
 =?iso-8859-1?Q?15IUjky+Ai305Z3Aps7VqwP0kvucSbzInvLML1hg6YWhZb4tqCXFQHmX+5?=
 =?iso-8859-1?Q?F5i92/13/ElYxCScIXSMzyDViWSfo7decjs1SWKz3qnt6UtUefsCzG7fZr?=
 =?iso-8859-1?Q?s/aqTF8WaJMDtt+C4M64OR+ggCs2KZ7MvWlbinMtqpCH9qwOVy+8V9ToN8?=
 =?iso-8859-1?Q?oF9AKo30l3Q+rPsAySpa68mWv5aWALFPxIFbS4ETMHCaeeXjWju0e2pYoE?=
 =?iso-8859-1?Q?Ow5hPiQPjtafM34XOhYr4SWkHeHbkhCAElELR6OWU7UH6Ms+dFfl+6UExe?=
 =?iso-8859-1?Q?QGEEma7xFaNkIsXu0SzJI+eFXnT/k+eLtCLeawAzxMx66rXDRMm31Pvtjl?=
 =?iso-8859-1?Q?qtLFxB33VDckVzdwzFMkVtaYb8wbIvrpZyPFe+dyb35DV7Cq0m8eNuU9QS?=
 =?iso-8859-1?Q?+AjmTO40hEWwX9euIC/1/UywtbalorT0fDjggNA4/dx59saPfPoAUT1ANK?=
 =?iso-8859-1?Q?Q5hDlzTkLi+bmyVVAtx9NrIhDDFrYktHOE2MxdX3AM1jneSfR/AEIbKZrO?=
 =?iso-8859-1?Q?JVPfaszlWhgUxUZhHW9DnBIyFCXOon50mqbARX058jVRsYBbljIsMCBXGR?=
 =?iso-8859-1?Q?/fcE5xdrBRUTijcVwo2zXr0QEhibJs7ZYLAzxDl+DqZqcq1zCEpI7I3eDZ?=
 =?iso-8859-1?Q?2zQxri+edbE3obV79mZFwCTkb3GfB8B7ke9YUnkUc71WkBNr67IvVT57Fk?=
 =?iso-8859-1?Q?jTLGcJg6Ob+rAde6Kz1SSanmNBvl8A1ZLwaxiX0AKW5Q6Hw8WH3scIJbqs?=
 =?iso-8859-1?Q?TLP3CYDq2A9h8rPgMk9osHbHqk8NiijqTdGZf2LWJIwIi7MRzRxVq3MWt2?=
 =?iso-8859-1?Q?ZCCbzLJCBT6wIcLuKUdnN4yffTzNoPBe4fElZmf4AQZ3s+pmkIaRacWhvD?=
 =?iso-8859-1?Q?IaRNm/zkoZZcPFM6ADEPs4/YOZmJvRYjiEhtjoighHf+rTr2L5F/n2kMdP?=
 =?iso-8859-1?Q?q0+fO/I2AgrVtFyn28ntY9uhUnovS6VsrjMq+SdpZTnuin3iYdg1MTUqjM?=
 =?iso-8859-1?Q?lRvJ8tPato5TXFvPCOvxyd0X2Oe8eUARRE/F/14WrJ8ISMtpxbTck+fKsp?=
 =?iso-8859-1?Q?8HJySKwDeGfz/my/IUGIWxtEolorn4bbiI+qN/4R1pp8OfwSXluvwqmDhe?=
 =?iso-8859-1?Q?gMNoTjaLqKpmxfZmiNFXrk8lXyMRrNwWljt0Cnf7L0JUCSxQ8lGU36AeYU?=
 =?iso-8859-1?Q?AXl8+0fR5NKptsb+AdiojNpHkXP5aOV+G/hw+dt4KQMl60nI/HJyPAHdO3?=
 =?iso-8859-1?Q?QygF+v8Ihnkxgexs6SzgoxTNSfv7z7YpQBGL4eiS56Y7h7sy4lfqfsS3HJ?=
 =?iso-8859-1?Q?iUE/D306tMSWtSgYO+A/WhMIqllDU4bXSkPnO+pJQAWn1rvLryP39q20ma?=
 =?iso-8859-1?Q?eYDxjwQECgQ9B+H9kCAqKMEs0rZj6v9mkwjZvw95FQ2Rs4Koa/b5uZeksL?=
 =?iso-8859-1?Q?J9N3q8rawQDdWSHsC5CYXwYoxnBLwl+T0ulshvnSNXUAP7Bkbhgbz6MKpB?=
 =?iso-8859-1?Q?ixEJkG3ccUpSh0QTU+duWYONM53OI6PHWOt25DPgJb62TCZDXO71aLtZw7?=
 =?iso-8859-1?Q?HJjbbvbLUL7vlg2M3tQpGm6kmRUbxi3HPReeSK6kfOUhgRYQoI79ftkJXM?=
 =?iso-8859-1?Q?/J1LFgWpmkesgeyKrWCEfJYmfkG3UNcj2G6fej3g+U7qgtR2v+aW8AZieD?=
 =?iso-8859-1?Q?wHj91ADIRH59r0IWxJ7EU8WsHUOY7jH3rqk4nuhY6QZobhEe2SZ4M5B0Sv?=
 =?iso-8859-1?Q?7tv/HuzVaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a07f94-3c61-4125-70fa-08df041e5523
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:34:03.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvEBFluxo6DV3vJ0pi/VZgu7j+EB4GAWtfDHCjLKowVm9nfya9sYyY6gBh2IwR8lppF7qF23ExiNikA4/zuxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

On Wed, Aug 05, 2026 at 01:55:21PM +0800, Richard Cheng wrote:

Hello folks,

Just a gentle ping on the series, thanks.

Best regards,
Richard Cheng.

> CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and
> §14.13.10 ("CXL HDM Decoder Zero Size Commit") permit committing an
> HDM decoder with size 0. Firmware may commit and lock such decoders so
> the OS cannot program regions through them; this is a platform design
> choice rather than a specification requirement.
> 
> The kernel currently rejects these decoders with -ENXIO during port
> enumeration and aborts enumeration of the entire port. On affected
> systems, this prevents the CXL topology from appearing in userspace.
> 
> This series enumerates empty committed decoders into the topology while
> keeping them out of region assembly.
> 
> Patch 1 is a preparatory cleanup with no functional change. In
> poison_by_decoder(), "rc" carries both an error code and the loop
> control signal for device_for_each_child(), so returning it bare is
> misleading, the early guards mean "keep walking", not "no error".
> Zeroing "rc" to forgive an -EFAULT on a RAM partition adds to that by
> discarding what the device actually returned. Return a literal 0 where
> the walk should continue, and test the forgiven case directly instead
> of rewriting "rc". Patch 2 extends this function, so cleaning it up
> first keeps the functional change free of unrelated churn.
> 
> Patch 2 makes zero-size DPA reservations first-class. Since the resource
> tree cannot represent an empty range, an empty decoder is backed by a
> separately allocated resource. This keeps port->hdm_end, skip handling,
> and in-order DPA accounting consistent. Operations requiring non-empty
> capacity, including region attachment and poison queries, are guarded
> appropriately.
> 
> Patch 3 adds the mock_zero_size_decoders cxl_test module parameter,
> disabled by default. When enabled, it installs committed, locked,
> zero-sized endpoint, switch, and host-bridge decoders under
> host-bridge0.
> 
> Tested on arm64 with cxl_test and the ndctl unit suite (ndctl
> v85), on a kernel built with KASAN and lockdep enabled.
> 
> Full cxl suite with mock_zero_size_decoders off:
> """
>  1/16 ndctl:cxl / cxl-topology.sh       OK                7.50s
>  2/16 ndctl:cxl / cxl-region-sysfs.sh   OK                5.29s
>  3/16 ndctl:cxl / cxl-labels.sh         OK                3.44s
>  4/16 ndctl:cxl / cxl-create-region.sh  OK                9.97s
>  5/16 ndctl:cxl / cxl-xor-region.sh     OK                5.77s
>  6/16 ndctl:cxl / cxl-events.sh         OK                2.89s
>  7/16 ndctl:cxl / cxl-sanitize.sh       OK                5.74s
>  8/16 ndctl:cxl / cxl-destroy-region.sh OK                3.84s
>  9/16 ndctl:cxl / cxl-qos-class.sh      OK                3.22s
> 10/16 ndctl:cxl / cxl-translate.sh      OK                0.95s
> 11/16 ndctl:cxl / cxl-elc.sh            OK                4.22s
> 12/16 ndctl:cxl / cxl-dax-hmem.sh       OK                4.60s
> 13/16 ndctl:cxl / cxl-region-replay.sh  OK                8.74s
> 14/16 ndctl:cxl / cxl-security.sh       OK                1.83s
> 15/16 ndctl:cxl / cxl-features.sh       OK                1.45s
> 16/16 ndctl:cxl / cxl-poison.sh         SKIP             11.66s
> 
> Ok:                 15
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            1
> Timeout:            0
> """
> 
> The reason that cxl-poison.sh is skipped is stated in
> https://lore.kernel.org/linux-cxl/anKpY6Y1Sqne1f7Y@MWDK4CY14F/
> 
> Both run_poison_test() rounds pass, so everything this series touches is
> covered, only the unaligned translation section is unreachable, and the
> series does not touch translation.
> 
> The core patch was also previously validated on a Montage CXL Type 3
> device.
> 
> The corresponding ndctl test is attached at
> https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/
> 
> 
> Changelog:
> 
> v8->v9:
> - Patch 1: add a poison_efault_forgiven() helper and use it in
>   cxl_get_poison_unmapped() as well.
> - Patch 2: rebased on that helper, no functional change.
> - Patch 3: no change.
> - Fixed the test environment so cxl-security.sh runs and passes; the
>   suite is now 15 OK / 1 SKIP. cxl-poison.sh still skips, see above.
> 
> v7->v8:
> - Split the poison_by_decoder() readability cleanup out of the core
>   patch into a new preparatory patch 1.
> - cxl_dpa_request_region(): split the declaration from the allocation
>   so the allocation and its error check sit together.
> - Add the missing blank line between commit message paragraphs in
>   patch 2.
> - Patch 3 is unchanged.
> 
> v6->v7:
> - Rebase onto cxl/for-7.3/cxl-type2-test.
> - Patch 1 is unchanged.
> - Adapt patch 2 to the refactored Type-2/Type-3 decoder initialization
>   paths.
> - Integrate mock_zero_size_decoders with special-topology parameter
>   validation and reject its incompatible use with fail_autoassemble.
> 
> 
> Richard Cheng (3):
>   cxl/region: Simplify poison_by_decoder() error handling
>   cxl/hdm: Allow zero sized HDM decoders
>   tools/testing/cxl: Enable zero sized decoders under hb0
> 
>  drivers/cxl/core/hdm.c       |  55 ++++++++++++------
>  drivers/cxl/core/mbox.c      |   3 +
>  drivers/cxl/core/region.c    |  69 ++++++++++++++--------
>  drivers/cxl/cxl.h            |  10 ++++
>  drivers/cxl/port.c           |   3 +
>  tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
>  6 files changed, 193 insertions(+), 56 deletions(-)
> 
> 
> base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
> -- 
> 2.43.0
> 
