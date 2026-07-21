Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C73C140E;
	Tue, 21 Jul 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624255; cv=fail; b=Ra3ILCSMoSpsELP0Jq6ivqbBsO4C5CjsCjfUZRIELK5LjRD6dTFO5nztN7+CSbYwFxiCi635PQRq4pGHzAzIAvFEcsMyj13Xh7vj4CsgtG3AN2JU5QQupCWdQ+AEQvGnbfb4wprVFuihxo5/gwDgwqMy5mgoLP8QhB+eE6arXf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624255; c=relaxed/simple;
	bh=KH1os93FaPStgtiEGTEcdcpPIdcsCIOwKhZbC4+eo7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5nMlWCRr7MYtpl29f1i0Q4XnmAZiSWWYi6dByX4pheXRh319cJZl4bH2s9S/x7cCclvKbGdVAdZbMSzFEVF1vaK1NYpm+fimCdArEhF9bzRfqdeCJ6IJulsojfb0EH2/gdYsafYhN8YhvGbokZ6OXllRy+dczQWcuSbqHpmPow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qsj1kSCE; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qsj1kSCE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi83uG3VupBGvPV2YOZOeWOrnhJirbRrv0vjVdY3waG1e0BHRz5Pu7sG3WEL5YjPz69k2qtnWAFjucGteq9h5kBujLAaVldZfaVqXCJ9IYF6i/1Eu2bWyge3iyYECdXfaVTuIGmjQ6AcSjNe5/+gKzZv7lfqsq+bTO7TqTA3QB4cOMzYo6G65es+hK6UuMwaMduEJvRpKoF565Q1Bnq3idgukpXxSv3zdSNlilfussxh8AHRFuWYMDOoFCbgHHNcatxnhW8MHYtYWQEBlm7wZw/HgxWXHlXQMpi/rlsIcezMdNLjqhz5PdE5KbCGThA7t0STPiYvx82jPEcPaStMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm4DwIxqtUPZEz7tx0D2tqdxR8j6FGJkARhks20i1VQ=;
 b=sUs/H0zjwttt/YfmpzBhUp7K9bdE9MkSjI6/iAsSrVB8A8YFetSNkDFjm1qIF0tgMTtMC4SJN2BAJVzlnN5wbLGahTN2EuKa2ulH8oXyapWTHOt8DxuEmI2CkT4EpbBY7+NaC4NT1qVh0f7wBfSwTDXh0T+YABUEX/GyAhexJ9s7EGX/2aQDtSTtzyPS/qFCSOYQuVJ26y2r5C/ZS8z8Jog0mvydc/bsX3IqdXYCTumitrwSEcj4E6/VQpVPVobHIA/4em0geVgsd3PSdnG6Zh9iPGvU1w15Pckmr6mbj/AzI8V6qVMhIBVlDrN65+wbdqQL998XkdQPEd9cAQ4X1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm4DwIxqtUPZEz7tx0D2tqdxR8j6FGJkARhks20i1VQ=;
 b=qsj1kSCE7HybOD1vjoPkOkz9rLxpvEs5+9VLtS6/lZ/ZQBIXW8o1541FK8T6gnv+2mh61mj56rDhkFjE2sI5dDS96UEKWP8aJs16/xsdvSx6CuZw2Ukqy23naIR2HZz3GjpAFdL8gbPo28TvcmUTO/kktazfOwRR9SpK8mKCneKDJGIg15mRQ+QU2UnuOs5RliZfeEz4+SgSPiIDK6dt4EJWn49VZY0G5zl7h/rxGiw7VDlYdfnB6Iuvk6ob0TJtP/CViIiUc+2onWatryhf8AnrR5Xg/8RHSnCc9XmjVs3o5xv6Kp/UTWjLsAOu1VyX8xmRMtIaFYAycuEUdFulaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 08:57:29 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:57:29 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>
Subject: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders
Date: Tue, 21 Jul 2026 16:57:14 +0800
Message-ID: <20260721085715.39322-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721085715.39322-1-icheng@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd0bd00-063d-4463-6b7a-08dee7061821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|56012099006|11063799006|5023799004|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dhZ9bJ3CJpXfRKRr2ayESM1vS6cYGfFG4TdGu3T0LMB4WD0hhwcqNRP8zBqFdeCMMeJKVONG/pnRa+3/zwCJiNnjOkEro9P/sUZvHEjEjkna6LI59r5+8gJxd4rGAYJKwAwULMxtf/7jS6dY2fSA4sYqNGXLiNJeBKwTRYgPFp9rjBz/6r1SNhLt2o+SDZ8+EuuR0p4uDqdvbtIHspIRTsJ6OhN7Vkh6DXNebWTrbhYgp9JkSmXqQ47SJA4F5NJEF6qGcW1YXwjlFS9egXvvV6qmkVJHOLoLbeQ1U/3EuLQgeYcB5PlynewpAFuz1uuMUWe719FPPZymx3sozAtJITR2NIp12DADoFSfY2KD2zfczpcjEr3xOGsXNGDe2pNtetYa4yAKbSCQRlEQvEmbjK3xYdSV6SucZ2W0YKL/A7vdzRohEEXoAkJsojJWSzEGpe87hr6dcjobqTLLYEpvcddE7kqDbgAh7+lRggeO4UY8NFQjq3t+ljZMRpVjBSXqh0sOooOZRof8wxBzT5/iz5Jpj/A43cvSB1RrHGX7lhPFSmHGSjk5E9lGr5oOni6UEO87MT2f/qkYSiKeHxb64r1XV5XCgC4JwfXyxLpQN+/YveJkgInKWo2R3fnZ+nGzWGGDZFjW7AfWrsS5QJjoCJz25d82w7rM3FgEB+fC+8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZYbFMyLytSQkJyQ0RBUlV1eUZBamNkZXNQdTllbmRldTg0OHdOcCswM3lk?=
 =?utf-8?B?RTRrdEVQY1pSci9lSTArM0IxRVY3SVBPbDZjNGNvS1dKTTVBTTBqYU9GUUtu?=
 =?utf-8?B?NUFvMFQ0OGszcXRFaDJvcjNlY1pYYW9Fa3ZUMTFnRVlzUjZpU213K3BFaUp1?=
 =?utf-8?B?WmtoblBpdUxhQlR3ZkRXYVlkeWRWNi9rRjl6QS8xenppcGZCTjFHRUczYk1n?=
 =?utf-8?B?b3hLKzFtRHJqRVlvai9jRjkzcWNOS0IvQ1VkZjYyTlc3TTgrOFNhTFNDbVpl?=
 =?utf-8?B?WVREaWZ0QzJsclBnWllXZDFaQUg4WHc4MFpGY2tzZVVsK0FSM01SWFNldnhZ?=
 =?utf-8?B?WHJ0dTBINWJUa3E0MDZwVmswWWFrRVdGWm0wWldwSmMyTkZOR05WWXBhajZC?=
 =?utf-8?B?b1NiNzJUcVRPbmZlZ3BobUoxa1dBbiswQnNaUXpwdzVQZ1FEVGs1Y2tzeDV4?=
 =?utf-8?B?bW1KTUZ0ZStBdUlSU2IwVmZzSXBhTG1TdFVaZkVsb1FDdi9pL29QU0xSWlNw?=
 =?utf-8?B?NUJZTmpoUmtYNEJLbVpqUnNHRW5HejB0V1VYL1ZzVzBLVXM1ay9uVnNyVXk1?=
 =?utf-8?B?WjN5MWR0dkJ4V2FMaFFRV0VRUHdJQWlaQTBzeE16dDdsOFZCUTRqOUFFeHJo?=
 =?utf-8?B?anNyRXJ3ejV2dXlKby9XSXpadGNzSDNaWUcwaW80RllBWE1pM3kvN25mN3h0?=
 =?utf-8?B?dG55MzQvdmxNL3JWNi9QaERGS3NIYkNJUm9LMlFRS1VaTXg3UHRmNzU3RStl?=
 =?utf-8?B?blZXVjhJMUZVNm9kb21PYU1CZ2d6emJoaHFwV3NGcVBXbUsxdGR4d2ErZWpq?=
 =?utf-8?B?TmZxTTNPTFpHYy9WVUgrWGFYTlVtSnB5b1NoZ1Q0a2FOQ3Vndzk5cVk1SHQ0?=
 =?utf-8?B?RGVhSmszellocEVEOFphakdWd0QyelFtenk2enREd1FFZXhwSXdhZUF2UjBX?=
 =?utf-8?B?bytXaXhPQlZrVkd4MXF2ajI5M2p4YSt3ZDVpT1YwSzB5em4wS3RnYmp1K2NQ?=
 =?utf-8?B?NXFNWTRsdUxIYVo3L1ZXSXAwTzlHTUdVd0lDQ3RUK0FhbFR1MnJZMkNTaXdZ?=
 =?utf-8?B?S05jQkJjbUpzT3IxcXNXK3ZQemlRQlBGbmR0NzAyV00wM2VQZFpFaFVTRkM0?=
 =?utf-8?B?aGRWOEFFRUFKemdMNlBtdzEzbmgxYTkvYXRBU1FrZ3BDZ0ovRDdPZGNFSlhP?=
 =?utf-8?B?aWhXYTFqRWFmZ1lwWXBwSXh4TUZBQkRDSnNhekNuSEFvdkt1eHI1Z0VHYUY4?=
 =?utf-8?B?bEY5OXNwdzVkWmVUTlRJWnpKU0V5OGtlWnVzR3dvc3lBemMxVE1WZzl0WVFp?=
 =?utf-8?B?R3l3b0xJNkNjRVBkd3FJMlIyZ1N4WWhBN0hhOEkzY1Q4THViOXNxakNjdDUw?=
 =?utf-8?B?SDA4R054cDE4UXVJVTdSSGlsRzA5NldEQ0NQYTNsU1RpTGVXb1FYcnZ0Lzgz?=
 =?utf-8?B?RkliUUp4Z01wekRzL0J5S3dsSEh0dE9tUk1xNTdEVTVNRVU4NG1jd3BiSzRQ?=
 =?utf-8?B?WVVhbGozSkkvQUwrWW15aGRUaDg0LzcyRllvUVRYemQ1RUN2K2tDblVGYzJr?=
 =?utf-8?B?T3RuNFdGTngyN2ZkOUlhVEFQTlFMQkpHWU9OL05IRWR2TkVzdnkyMGpmNzhv?=
 =?utf-8?B?QWU4MjJOQjZIMTVWMUwwaHRQdU1HR212ZHZYTWo2T2RVcmlVcnEwUnA0b3JR?=
 =?utf-8?B?ZEN4VzZMTG4xd2RhY2pJbFEybGtuV0hZOWdYTHVqRnlMYWd1dUdqUUNCekl2?=
 =?utf-8?B?VWpsalFOeVlTUDljVWE2bytxcjBwV0FGaVM1Y3RicCt1UDB3ZHYrYVdWbTdn?=
 =?utf-8?B?d2N4Um5BOWFuTkJENUhhMmRZQW81aDZJQ0tKVml4MVNQS2NaT2RrZ3UzRGps?=
 =?utf-8?B?ZVRnS1dwbE8rRnh3K29rMjNoM3ZvMXVCd2pRcGtCNHdwMjRhdTd0bmYwOTNp?=
 =?utf-8?B?ZGpDNHQzNHhqT0pnY1Q0SnVtZEtPWXFsTFBwWTN2NUQyQnd4eWFPMk1SSlRW?=
 =?utf-8?B?WUs4ZWE3d2VYV1lXRlN5NEU5K3FyMnFkMU5HUk5XT1RaeStvV3E0aXFkVEQv?=
 =?utf-8?B?UCtOcDJUeHl2blJWVzE5OHBGZlRJR25IbzhjWlZiSlF1VDFuS1hwZFp6MmRJ?=
 =?utf-8?B?UmhTTXpWWmR0SURZbUhyQnJuWlJFZGxsUGYrbGc0clJFSXRuTUZkUDYrUEJC?=
 =?utf-8?B?ZEk4cUswTFhxT25qdDVua1FuT090REltVlRIeWtqbTZ1U2RPQmU0UUdwOHVM?=
 =?utf-8?B?STkzVG9Mc2xlazJoV3o2UXd2RkI3T3BBaU1DeGJCc2pMRUYySWc0M3VwV1ZO?=
 =?utf-8?B?QzQxeXVuMG1vczBpYkhVSnZGK3R4M29qRnZZWEIyQzV4WmtUNFloUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd0bd00-063d-4463-6b7a-08dee7061821
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:57:29.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knEFUY2jHYLPe7AfEXuMPMBRSJFwtDMq+aKePe0aUrue0lf4F7ToHgw28FzNc/aj4F2kc8nUbKCBwyaeSaPopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
with size 0. BIOS may commit and lock such decoders so the OS cannot
program regions through them, this is a design choice rather than a spec
requirement.
The kernel rejected these with -ENXIO during port enumeration and aborted
the whole port, so affected systems showed nothing under 'cxl list'.

Treat empty decoders as first class instead of special casing them, back
them with a kmalloc'd resource, since the resource tree can't represent
an empty range, and keep the skip and hdm_end accounting intact. Guard
the paths an empty decoder can't serve, e.g. region attach, DPA free, and
poison queries.

Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
---
Changelog:
v6->v7:
	- Rebase onto cxl/for-7.3/cxl-type2-test.

v5->v6:
     - Comment wording fixups, no functional change: reword cxled_empty()
       per Dan Williams' review and tidy the poison-walk comment.
v4->v5:
     - Rework per Dan Williams' suggestion: make zero-size DPA
       reservations first class instead of bypassing reservation.
       cxl_dpa_request_region() returns a kmalloc'd resource for size 0;
       cxl_dpa_release_region() kfrees it on teardown. hdm_end now
       advances and releases for zero-size decoders under cxl_rwsem.dpa,
       and their skip registers are honored.
     - Corrections to the posted sketch: add the missing return after
       kfree() (use-after-free), use IORESOURCE_MEM flags so
       resource_contains() can resolve cxled->part.
     - cxl_mem_get_poison() returns success for zero-length queries
       before issuing a mailbox command.
     - Fully-burned device (all decoders zero-size at DPA 0): cxled->part
       cannot resolve; gate poison_by_decoder() queries on part >= 0
       (the part[-1] OOB read was already reachable for sized decoders
       that fail partition containment) and scan all partitions when the
       walk reaches commit_end with nothing mapped (sashiko report).
     - Drop v4's poison_by_decoder() restructure and the hdm_end
       non-advance approach; superseded by the above.

v3->v4:
     - Drop the port->hdm_end advance for zero-size decoders (sashiko AI
       review). The write was outside cxl_rwsem.dpa, and advancing the
       watermark without a balanced release strands hdm_end and breaks
       LIFO teardown. It is also unnecessary -- zero-size committed slots
       are trailing and locked, so the in-order check in
       __cxl_dpa_reserve() is never reached past them.

v2->v3:
     - Advance port->hdm_end for the committed zero-size decoder so a
       following committed decoder still passes the in-order check in
       __cxl_dpa_reserve() (it was left un-incremented in v2).
     - Fold the poison fix into this patch: commit_end may now reference a
       zero-size decoder with no DPA resource, so poison_by_decoder() falls
       through to run cxl_get_poison_unmapped() and scan the unmapped DPA
       tail.

v1->v2:
    - Add zero-size committed decoders to the topology instead of
      skipping them. Drop v1's -ENOSPC sentinel and the matching
"continue" in devm_cxl_enumerate_decoders(); fall through so
add_hdm_decoder() registers the decoder.
    - Set port->commit_end unconditionally for any committed decoder,
      not only non-zero-size ones, so subsequent decoders satisfy the
out-of-order check.
    - Add an explicit early-return before devm_cxl_dpa_reserve() in the
      endpoint-decoder path. __cxl_dpa reserve() rejects zero-size
decoders
    - Spell out TSP and TCB and cite spec sections in commit message
    - Reorder series, implementation first
---
 drivers/cxl/core/hdm.c    | 52 ++++++++++++++++++++++++++-------------
 drivers/cxl/core/mbox.c   |  3 +++
 drivers/cxl/core/region.c | 49 +++++++++++++++++++++++-------------
 drivers/cxl/cxl.h         | 10 ++++++++
 drivers/cxl/port.c        |  3 +++
 5 files changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..ccbab2e21f06 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -240,6 +240,18 @@ static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
 }
 #define release_skip(c, b, l) __adjust_skip((c), (b), (l), NULL)
 
+static void cxl_dpa_release_region(struct resource *parent,
+				   struct resource *res)
+{
+	/* zero sized decoders are not tracked in the resource tree */
+	if (resource_size(res) == 0) {
+		kfree(res);
+		return;
+	}
+
+	__release_region(parent, res->start, resource_size(res));
+}
+
 /*
  * Must be called in a context that synchronizes against this decoder's
  * port ->remove() callback (like an endpoint decoder sysfs attribute)
@@ -256,7 +268,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 	/* save @skip_start, before @res is released */
 	skip_start = res->start - cxled->skip;
-	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
+	cxl_dpa_release_region(&cxlds->dpa_res, res);
 	if (cxled->skip)
 		release_skip(cxlds, skip_start, cxled->skip);
 	cxled->skip = 0;
@@ -336,6 +348,23 @@ static int request_skip(struct cxl_dev_state *cxlds,
 	return -EBUSY;
 }
 
+static struct resource *cxl_dpa_request_region(struct resource *parent,
+					       resource_size_t start,
+					       resource_size_t n,
+					       const char *name)
+{
+	if (!n) {
+		struct resource *res = kmalloc_obj(*res);
+
+		if (!res)
+			return NULL;
+		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
+		return res;
+	}
+
+	return __request_region(parent, start, n, name, 0);
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -349,12 +378,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
-	if (!len) {
-		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
-			 port->id, cxled->cxld.id);
-		return -EINVAL;
-	}
-
 	if (cxled->dpa_res) {
 		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
 			port->id, cxled->cxld.id, cxled->dpa_res);
@@ -378,8 +401,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		if (rc)
 			return rc;
 	}
-	res = __request_region(&cxlds->dpa_res, base, len,
-			       dev_name(&cxled->cxld.dev), 0);
+	res = cxl_dpa_request_region(&cxlds->dpa_res, base, len,
+				     dev_name(&cxled->cxld.dev));
 	if (!res) {
 		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
 			port->id, cxled->cxld.id);
@@ -402,7 +425,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				break;
 			}
 
-	if (cxled->part < 0)
+	/* Empty decoders may not be contained by a partition boundary */
+	if (cxled->part < 0 && resource_size(res))
 		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
 			 port->id, cxled->cxld.id, res);
 
@@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	struct device *dev = &cxled->cxld.dev;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
-	if (!cxled->dpa_res)
+	if (cxled_empty(cxled))
 		return 0;
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder assigned to: %s\n",
@@ -1031,12 +1055,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			return -ENXIO;
 		}
 
-		if (size == 0) {
-			dev_warn(&port->dev,
-				 "decoder%d.%d: Committed with zero size\n",
-				 port->id, cxld->id);
-			return -ENXIO;
-		}
 		port->commit_end = cxld->id;
 	} else {
 		if (cxled) {
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 97b1e61ad018..ffd24992273d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1384,6 +1384,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
+	if (!len)
+		return 0;
+
 	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..6c7d9a52707c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2115,7 +2115,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (!cxled->dpa_res) {
+	if (cxled_empty(cxled)) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return -ENXIO;
@@ -2959,28 +2959,35 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (!cxled->dpa_res)
 		return rc;
 
-	cxlmd = cxled_to_memdev(cxled);
-	cxlds = cxlmd->cxlds;
-	mode = cxlds->part[cxled->part].mode;
+	/*
+	 * Handle the degenerate case of a device with only empty decoders. An
+	 * empty decoder can still map a non-zero skip range, so advance the
+	 * walk to commit_end either way.
+	 */
+	if (cxled->part >= 0) {
+		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+		mode = cxlds->part[cxled->part].mode;
+
+		if (cxled->skip) {
+			offset = cxled->dpa_res->start - cxled->skip;
+			length = cxled->skip;
+			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+			if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+				rc = 0;
+			if (rc)
+				return rc;
+		}
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		offset = cxled->dpa_res->start;
+		length = cxled->dpa_res->end - offset + 1;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
 		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
 			rc = 0;
 		if (rc)
 			return rc;
 	}
 
-	offset = cxled->dpa_res->start;
-	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-		rc = 0;
-	if (rc)
-		return rc;
-
 	/* Iterate until commit_end is reached */
 	if (cxled->cxld.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
@@ -3002,9 +3009,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 	};
 
 	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
-	if (rc == 1)
+	if (rc == 1) {
+		/*
+		 * No decoder with a sized DPA reservation was walked
+		 * (every committed decoder is zero-size): scan all
+		 * partitions in full.
+		 */
+		if (ctx.part < 0)
+			ctx.part = 0;
 		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
 					     &ctx);
+	}
 
 	return rc;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c0e5308e4d1b..cef53d9bd5c0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -336,6 +336,16 @@ struct cxl_endpoint_decoder {
 	int pos;
 };
 
+/*
+ * The common case is decoders with no reservation, but also handle
+ * decoders with a zero-sized reservation that firmware may install for
+ * security lockdown purposes.
+ */
+static inline bool cxled_empty(struct cxl_endpoint_decoder *cxled)
+{
+	return !cxled->dpa_res || !resource_size(cxled->dpa_res);
+}
+
 /**
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99cf77b6b699..c12fd0b89883 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -46,6 +46,9 @@ static int discover_region(struct device *dev, void *unused)
 	if (cxled->state != CXL_DECODER_STATE_AUTO)
 		return 0;
 
+	if (cxled_empty(cxled))
+		return 0;
+
 	/*
 	 * Region enumeration is opportunistic, if this add-event fails,
 	 * continue to the next endpoint decoder.
-- 
2.43.0

