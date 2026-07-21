Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E13DEFE7;
	Tue, 21 Jul 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628040; cv=fail; b=mcKtLJQVOYeJ35H3IGqw4ZTohXQZ7u7tAxE998zSLNsbT5K6qLVdnYWWY7d0/qImHgQGOLNNb7AnW4FvO8zJciA3tQTZoD/rsJcyxCh7uwTAQlJhTLTUyHJfVOS7Ni9bAdLC/mOxBc1OvwCr/2V5rMfIFyrpQb2cPGFYlX+gjJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628040; c=relaxed/simple;
	bh=CgvaJZefw1CizzQtEBk4hQfW3kwG1+m4yOqnb295V/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rW/fEouPXoQszMl0Zv8Qo3nNkbXLarrnQji69jNdlMfyvwPeKtOkpwN1u7lD9oWklV3YsYCBleS+mOSAiWqbjU8hRZtUdQeltSFHrUYBgjgTAG19NhiagLUqCcSvYW38PSIVhN7GOu4LsqZ1hsvmM/i9mLyMt3DY8kzh5QhYpXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ecIzo+OF; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ecIzo+OF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjcolYdVix1GqDTNatGSmrEhYegvT3BNnCL6G5NIZOGknBVvX0DsJd7YMYD0S3gmCNHWT7wFcCCLT3vPIxn9PVEASPLw9hwGc5s9gHxQaHmBob19z9mOfAsw7oYdfySNOkdJPm50S0ASqVsyIxQEy3Y/ddY5ycozQSLl/Llshbz/O6f8Te3ATrL0XIabp1TEr/qYdurJM/rtiynFfk1Nej5Zi2pF1llNJUVlMhMn3bA2uUzs0QqjarBth8J2CYRQOFK7J5luCwpu8MJhfo5i2bt13OrPhd/LUJey2qpz4Xab9qzoS/5tF0eMqrqZ2KLor1KrgP+Xccpak9MKEtqyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FaB5mUSr2QR0rGiIORlSeJ8DRTfDuKmxjR6Zfbfcd8=;
 b=CzxzTtJpZUiQURG9B+HsTAcgE67JCTM3mk6nmQhnw22BcfYUeUX/8iM7R9mdip3b0UMdqJU3+GJwL9Ytbil09rkRh3MtXkrsCdwqRIcZKI9Ip6leZmyR2TIzS4zuoqVEfOuUt9zSyzXX/iTKxF6Qj6gtNqszo22A2lRtupAQc9DKdDLurCeLsljZpji3VCeKK9dh9xxLD7iFIGEHNjODU4XgNC+GLx9dwKdg8afLizjviGWR4bD505ZpF6078EIdNAozFhyzhzlqYtrOAFiugjD9g1vD+c2JRhnZ2WOEyWvFFrQQrxF4o6JXfKn8DwrDpJrfgXQT8syb0b1Iqqx/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FaB5mUSr2QR0rGiIORlSeJ8DRTfDuKmxjR6Zfbfcd8=;
 b=ecIzo+OF2uKn6MkL2k2v8igPJaFG2TZP3vKcO0uFkS3sKDTIkTVqA8oKF/qiFZ4yeC0g3gH9wwDbSaCDJ+RAgjDs61qt1Q8nSMqFynxpNmpsY1fy6/JmWuz3tENpddpUz1JHLFegtPkMrfn7FnQYWCbbEIWImuIpX19Kg1XilrqtzOwlhxtj6VlF7Jp6shvLhWho9NLEe7mvuuu/kfe96PkhwF74AsCpCzcFBpoba6GiNY9jdlsFMhPeEILHEmPQ3MuhH72+E9vGi3ueyvVJtzHBLKp8KHAXs3lTcyeIPmg31Xxc2Ju5Vh9/9sVUHTlpQcn7MJoYiM8GdDo/zJDUjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:00:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 10:00:34 +0000
From: Richard Cheng <icheng@nvidia.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	jic23@kernel.org
Cc: ryan.roberts@arm.com,
	ardb@kernel.org,
	kevin.brodsky@arm.com,
	anshuman.khandual@arm.com,
	yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2] arm64/mm: Check the requested PFN range during memory removal
Date: Tue, 21 Jul 2026 18:00:26 +0800
Message-ID: <20260721100026.10408-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 109380f2-b8bb-454c-c1db-08dee70ee7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	KlpHBeuqbacvLEePUfw/TFL2WRQ3rJCSIYrVUK/TcKdgdjcpPziisHQxYA0UiPHnBYNHp2pwD+pwa7Gh89XXUOG8kpBtzbWpCSJVz62ye9hgeuMxEu90iMFD7EcNY21U2eV8ey7fiXrtPAGCVyiRF8b4f/V0sWs299Lwh6Fi2d7HCBXzuLixwyNkqB9v6ZuLHoPLh8O8kanP482AQ97d5jgqVPsT24/oo/3J8FTKhV8nX+VSTvKl+/bpjG4YkKUA705qchkzXnzCl2TQ7r7ksLMDzVjg0xlDP4iUK3Ok3VyJEr8YXhOhs67mTnNFHCoi+3O0UYt36K5hkieNsfGAEAAqVlWMuSR5mAlEip3y2gu03W0JJdAH+SBScVxS8IMsPtb5sMw6Cb3gU98SOPBsm6ADQOwWbJLbwG+sDyhoYPxRprTasB7yqZ7zKB15dQreqoCB7GGS4oE7A0cjhRBfFjAvuH5IA6b/Jyg4uCnUaR/WgFnfjttZ7kzRS8ZT1sCMbKkoV5owEIIJO+uJS3Jg7oZsa+KZ2V/v+tDgsn/rfDXJSWVBXlwG0kNi/OOkQehFefnmYY9h3dArCTOh4+8nZiguseV3b0lRYWtvKEjowS/nyzGmreFg13lOv+96v6ITdKLvtWOsBGQE1SYye1KbTqsAknSxsqhB6oQ4O52s6Jo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oShFsHaN0n/tq+GNh+ZhByG5ItcPK4dI2Asvzdnkfs4hAIYXG3VvvEITKGFk?=
 =?us-ascii?Q?hVCWtMtrAulyFPNx1vXlTspvdPX2YPpcbCDM4/H2Eeb/RTGyXPD8EUWBzGrV?=
 =?us-ascii?Q?P4MFREIJ94Y1HZuOLDnM/DYbe+/cQCYDsRol8v0r6x9OyS8XFWru+3tjuNY/?=
 =?us-ascii?Q?J2o7NFZJ+X6W2hYgKic31uuZ8Caoc+pNxMzucYHarkrfNvhEUUWCd3SX4Jar?=
 =?us-ascii?Q?ydWxV55xvhjp6YLlMsKCFfvISM3yyL7kv0ZhM9RxKH8rslA+DzwpYlFaxlcT?=
 =?us-ascii?Q?DPsr0BwZPBSZjQh1K3QivWC7+JXgXq6ol4BY2G8aFIKYZU7UxVJCtAL9AOYJ?=
 =?us-ascii?Q?ppDwK19dgPFon9+3MEpGOrEkMx2nLhQeFub+1V6/JRS5rl/4k/qpfr1fFhj4?=
 =?us-ascii?Q?hLqz9BW9Zy1mCe284DgYv3i1JWpBv6oz4lgytnJ2d7QHDayNwaHtu6AN1B+b?=
 =?us-ascii?Q?oHn/uf+eB8c9iMflipNS4vLXRS+ggEkTFL8AOSl6M2vIMPVU/EsavbHJE2HE?=
 =?us-ascii?Q?3LQgksSgyee5HokfquVAPA8fa2oE+ABS5c+feDO7fmm8UCnsEynlcI9MfZVk?=
 =?us-ascii?Q?d8KM0aiO6hGOu4Ihk1GeOnHTqU6U3DTz1xNCsiQjyMAb5YpyxWKFVJ5tg6hV?=
 =?us-ascii?Q?Do7tXoe1SC7FQXaVgryWjQnA4hnSah2wWvGQS0XdLOtzmEusWAPm0u/iKBUj?=
 =?us-ascii?Q?O1Vc94zyrVy3q2CWX++GCddbsQdlWtHmLpNMJE7fdbP8JzUPklCcuar0774O?=
 =?us-ascii?Q?aFDWs9LQcpSXho5xB/2K5Ic0uRmFzfu/tmAM6TIUt6O4YDvhb9KsFQgS9H/z?=
 =?us-ascii?Q?0zRjvYywjV/2hkLtmejjzLJ5WEymNhUm45Rsbxz4UB8pxP/g5fCrvtsR8L9A?=
 =?us-ascii?Q?JRx6Y0dm/TzN0V8bfxOPnuKy7DTWMHqQ3TtOICTBbnTRVomBc/hWJU36pJX9?=
 =?us-ascii?Q?wPyL3QzUTlP6xDeTjPCnKV8QoXS5cazNsxkegEVFbawPy4dg7tHMI9mlPcE6?=
 =?us-ascii?Q?BCF0Lq5fW3Lt6GAtiXmTcFUlZ0LyOA3Mc1ZWHWMucDgq320yU41w9QQDRRNP?=
 =?us-ascii?Q?LbG4tcCIXA6lDZQ24bdqkiIkDbyXbQJaPY28KoK488DzbhLGugCVrXVsF/wM?=
 =?us-ascii?Q?CD29iRsMa08iklFwf8iumX011OFpbA4pKDwwXJoKheSFuMOZGmIVj7YUCBM5?=
 =?us-ascii?Q?JOAw1iUqkLj9rtvN2SYm6Q0akOa53Iz5PVx8a9S1vL5PRDJJdz7Lm7bJrjHB?=
 =?us-ascii?Q?O6mFPnWX2OP8Yl7zPZM2Sp4p4yHQu/IHLcyPN/0HpzNdATw7UdM+Cj/uB6/A?=
 =?us-ascii?Q?CQ9BMbicZNHWTcdL7CD69v7GhPwdm6FpmZn45m9S4HwXLRQmuFh+OPjXOBL2?=
 =?us-ascii?Q?2Mt+ed4ehSQajubpxBBbhEJ7TkISn3xhlAmbteVNfpJK/wqGSKRA1cn4MQqu?=
 =?us-ascii?Q?zwi+q0rZX34QdruhNMYZ4y+aLldNUxV3gPIUyLY2DC2pJnz1rgzBn0UkuPLR?=
 =?us-ascii?Q?tr72Ro6GmFkLPxZ7nSA8UVzkZIoVr/Tuo1Q5Ewr4xSU7DQ7cRHUPm5Upbu4W?=
 =?us-ascii?Q?6NaxjPYRBSGpFhsIDIjAyoojtMkas5OQ5bnI25lPixUoB7nwgzMEe4bopXcW?=
 =?us-ascii?Q?SRlyvn9xQKkoO2uI6kuBS9wVjxBPSlZMPoJ0dc0piC3sfNRQ6F5jEkxd6FF5?=
 =?us-ascii?Q?vRq3jOWcYPc7Mg4mpv0Rrf8ip1pkWmEMZ7YaN9hJFKkbJV0NqqNv8JNMdzQs?=
 =?us-ascii?Q?rApR4ewvjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109380f2-b8bb-454c-c1db-08dee70ee7e2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:00:34.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qflI6bq/i7GNLnHtW2UEuyP4TtMVnl0v2iuNL+VRAVrhlOEwFVFHVpCh5hiV/eCIgDFPqadnuavn4ey+o1BUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

prevent_memory_remove_notifier() advances pfn while scanning the requested
range for early memory. When the loop completes, pfn is at or beyond
end_pfn. Passing it to can_unmap_without_split() therefore checks a range
after the one being offlined.

Consequently, a valid request can be rejected based on the following
range, while a request that would split a leaf mapping can be accepted if
the shifted range can be unmapped without a split. This was observed with
CXL DAX memory, where the final memory block was incorrectly allowed to
be offlined.

Pass arg->start_pfn into can_unmap_without_split() so it checks the
requested range.

Fixes: 95a58852b0e5 ("arm64/mm: Reject memory removal that splits a kernel leaf mapping")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changelog:

V1->v2:
    - Fix the typo in the subject
    - Clarify how pfn advances and which range was incorrectly checked


The bug occurred on a machine with CXL Type-3 device.
Branch: cxl-next

Before 95a58852b0e5:

"""
$ sudo echo offline > memory557056/state
write error: Operation not permitted
$ sudo dmesg
---[snip]---
[440008000000 440010000000] splits a leaf entry in linear map

$ sudo echo offline > memory558079/state
$ cat memory558079/state
offline
"""

After:
"""
$ sudo echo offline > memory557056/state
write error: Operation not permitted
[440000000000 440008000000] splits a leaf entry in linear map

$ sudo echo offline > memory558079/state
write error: Operation not permitted
[441ff8000000 442000000000] splits a leaf entry in linear map
"""

My fix corrects the checked range and prevents the false acceptance.

Best regards,
Richard Cheng.

---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a25d8beacc83..18a8b0d3714e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2194,7 +2194,7 @@ static int prevent_memory_remove_notifier(struct notifier_block *nb,
 		}
 	}
 
-	if (!can_unmap_without_split(pfn, arg->nr_pages))
+	if (!can_unmap_without_split(arg->start_pfn, arg->nr_pages))
 		return NOTIFY_BAD;
 
 	return NOTIFY_OK;

base-commit: 5ca04f3ba91f1773bbd5da6d9c654ccc1ba7831d
-- 
2.43.0

