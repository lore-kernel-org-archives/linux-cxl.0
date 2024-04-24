Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978913BC3A
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989070; cv=fail; b=M/tO+XSKHRuejQdtNFwfSqC8xhHS1Q3blfwC/nyIKqkxJRwmxe2LKT5soApQ8ich73+A7sm+UGbbBk1Rj9h6pYCWxK8K7cpVdoddFXjJRdH01nGrtGWRzrh+ovrzHXDbtjI+0w9BpOaO7ka2qRD1aGGcKPZEgShuYZ5HgPnK+Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989070; c=relaxed/simple;
	bh=n6uLLVpW754pheV8P0lm/gJ67umDXl4IO0f47kciLqQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=syiXJ2JXz4gCdvues2N2k3Y3boYbSoV94i9wZGuE2TF+SkU8ONzfAhD45Oc1eI5kpWhBUm5b8te8GKRKQwnXx++DEMkNhTNNq3qj4mzqaGQTYWNff/F8HXndl4rAsR66vDdfUGvnzvMMDt6Otbjx5SdTNjfTecWmPDdcTv/MBvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=s/q0O0x0; arc=fail smtp.client-ip=40.107.223.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="s/q0O0x0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp0ICyZ1sfA4Sw2tJX0l9DT63LdbIPrxb/5SOZkurb29mCUgqvu7PheikZ9pBDGqAAyIKFt2Kjv4CpwuNTHy12bMMd5dTDqIRhwqCtkdpzDaU/BU+tncA/sTUmnIGIZQN70eQmmKwaosCPmE2S04xfS0psw5gWLf/DqAxZFJKQDw7FJgMFiw3XL80M1Labf3oSduRuUg0SlX4xjTOkm9PqcCj2ibFHvePe5+wSZwjOmpIKy+IbXopVDwQ9sy6mpIqlnVS5jjobzLuhHpMjFAQNhQxnLPJ5eyfTmlQmt0Gx355DD4VXjMbtCeGQPU0yO8kShljKxh5lw/vF3smJCXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnLdblsMRDSOzforEnHVVgC29eihoHuXi927zOmPpKo=;
 b=BM06Pbyx4NTojkaqYAkeEv83uTYt56x+UvtQua4Tc6uDquBR+j9GtUxG7z6UfCjDvh15QE8cLY8VWrzE+GcTrN5/cxcRQIlEWjt1yl/15YF71/nNYymGBtqMpRwq6Jw6nemTcJb0X965s/3REC/+PPT6WiPciZm4ECh8e1QnLkx+bD/OgllvSlRNZ62x1eSMI0oVmYPL0UggE+9hqkwi7kU9DvixVC+azq3+1QantIOQU3kv00NNP1EZj8D+jmUcuqamTHW8twKgtGHIYXhbKUSyI4TSUDS9gbtKVCMAltcJR7eZbOq6Q/bcTSWb5w1Q2xAfXsKWHWW5iqCwm+tV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnLdblsMRDSOzforEnHVVgC29eihoHuXi927zOmPpKo=;
 b=s/q0O0x0Bm7qb7c1mcqNlafTGInXxHY7yCtCNONhC/uNgJLbjSzjSMp2v8Ug2taff8VmVOJ06Qy49IHPOyl9NnCFhMOxEaUT4KphMZF/sKgeRhGaEW2ObITT+leUbh8/5tzGpdY2bXrncAtWV7JqH30qdyeZmmmVUofQKCv6bhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by SN4PR17MB5846.namprd17.prod.outlook.com (2603:10b6:806:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 20:04:24 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:04:24 +0000
From: Svetly Todorov <svetly.todorov@memverge.com>
Date: Wed, 24 Apr 2024 13:04:06 -0700
Subject: [PATCH RFC v2 1/3] cxl-mailbox-utils: move
 CXLUpdateDCExtentListInPl into header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-cxl-2024-04-22-pullahead-v2-1-a87fc4597795@memverge.com>
References: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
In-Reply-To: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
To: qemu-devel@nongnu.org
Cc: Svetly Todorov <svetly.todorov@memverge.com>, 
 Gregory Price <gregory.price@memverge.com>, jonathan.cameron@huawei.com, 
 linux-cxl@vger.kernel.org, nifan.cxl@gmail.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713989063; l=2156;
 i=svetly.todorov@memverge.com; s=20240312; h=from:subject:message-id;
 bh=n6uLLVpW754pheV8P0lm/gJ67umDXl4IO0f47kciLqQ=;
 b=NF0R9bPEmDxA0o18wloZn9HlVXqr89v6zaKjXN7GhBjqsO7E1hEStX3kiv6ycuffKFw07/ycf
 FtNZ8rFXREKC0bvxfubVbR2fZK8gD3vKaLOeS710Y2e4oYIkmJrEOhb
X-Developer-Key: i=svetly.todorov@memverge.com; a=ed25519;
 pk=bo0spdkY5tAEf+QP9ZH+jA9biE/razmOR7VcBXnymUE=
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To IA0PR17MB6347.namprd17.prod.outlook.com
 (2603:10b6:208:435::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR17MB6347:EE_|SN4PR17MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 776b3926-f936-4a35-912d-08dc6499bd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVdTalU4NDF2YlI1TEJJQy80b0pQMXZlT3h3RVdSdXBmZGVUUnlLUjFIMURH?=
 =?utf-8?B?aC9LOFc5SkFvT3dPRmsra0tZaWJjNGFnZ3V4RjZCOGtqQnF6R1dPZ3N1SGJ1?=
 =?utf-8?B?azRvckFjcnBPOCtrWUNLZ0tiZXFCcmF3VVpIb2dlZC9WL1ZGek51SFJZZGEr?=
 =?utf-8?B?bk1YUnBuV1RqMnY1Uko2Tkt6cGVjYk4xalIzUWdCYnd0b2pGek8xR0ZtNWdK?=
 =?utf-8?B?dVFIQXBVWDZ4c0RoOSt5YTlnOHpSdGI2Q1J3UWtCS25yTGN5czhGUnZhK1JG?=
 =?utf-8?B?akZGc3c0UjlCQy9laGJ3WFhoOGNWQnk2eUdyTHB1NUlER0pxVWxsLzFVenM2?=
 =?utf-8?B?VHJNd0Jvclcwd3dmMDR6d3NvclpoRE40RG1HWG5JYkp4dC9UNDhMWFBWQ1Jh?=
 =?utf-8?B?d2NNaUtFOFoyS3pJS1R4U05RMnV6WTBiaVpDRFczaUE2Y3BJWng1T3AySzAw?=
 =?utf-8?B?eWRrMlFrY0pveHFibnZEV0ZNdVBhT1R2MUNIVWgzOFpRU29wMHErVWRhdk9D?=
 =?utf-8?B?SW1wU0poMzFYUUR2WmZ4d2sySzA4VTNFM3hZTFpLQTNuYVliWUZFcjhGWFh2?=
 =?utf-8?B?a0FMWDZsY3Q1SE1NdnJUd2RUNzJYTFJaZVFvTWN1U3AzTTZiclAyeTdrd090?=
 =?utf-8?B?YndITVYzbHB6MW5vSmpSNS9HZ3BrTXJhZXFaa0lvVlNLdXJ6dFZHR2N3cHlH?=
 =?utf-8?B?MjVSK2xWd212aW1LeE9YOUErZ0V5T3p6SFYxVlI4Yy9qK3BkVGxqM1k0OVMz?=
 =?utf-8?B?Kzl6c0lZSUtDaWgzbFdSalZ1OThscHJNSU5LTDl0NjNoTGUydVBPS2hqT1ZM?=
 =?utf-8?B?MHVYaTVHSkJJRndKVWVHcWFQR0owcVJnTllVcjJlcldpR0ptdFp0YkVvclBz?=
 =?utf-8?B?dGhxY1U4NyszRkNUQ0tacFFmTDF5ampiK3g4RXpqWldaeVFoZDJ2Mkh2SHZG?=
 =?utf-8?B?V1hlbDh6OElxcEZ5MTJCcDBFTDRHSjdsMXh6aC84NFN1d29nNGxST2t4T2Ix?=
 =?utf-8?B?aVMrS0lsWGlDOWg1WldEN1dNNVZKWXQvQnVFVXVySkV4VzhPY0xSczJLTjZm?=
 =?utf-8?B?aDZacWRMcVdqa0xBWDdYRXhBNWNaMHdWNVJoaXhzTmtFYkZQWU9TNXh6ZDBx?=
 =?utf-8?B?d09IMVFkK0F2MXQ4Z01oM0M0QjdnNlJDNjM4c0JoVWcyajArTUFkQTJZdC9N?=
 =?utf-8?B?NmphTjEwN2N6MUJOTTdQa3JCd3IvT1B1dDZzeDZwNHZCSk9kWm82Zkp2ODBX?=
 =?utf-8?B?bWU4TCsxNXg0eFM4eXpJSE00Z01qN2tMVkFkR2hqNE1JNmc5OEhaOEM2Vk00?=
 =?utf-8?B?MThYTHdoeGtTTU55TWREMENicXVHWHptWS9tNURqM0VyT3hmSWwzbEhYSGlY?=
 =?utf-8?B?bnl6Wno2dnFySmc3UUNINUpWZHhTbHBya1pYMVF3c3VjbVNLeGh2US9FWG9T?=
 =?utf-8?B?SC9INWEvNUlGUXFoNWY5MzNvd3p3S2hkSXBLaXBqTlhVaktOWEdKNGtGNFRi?=
 =?utf-8?B?S0ZKYURhZ2tBNDNzSW4zWXlQNDYwYlJZcDdYSHQvZEMzMTBoaFNMRnRhNFJX?=
 =?utf-8?B?a1RZVmxzMUQwc29WVnZ4M3JmM08zME4rUTVZbFpQc1JVV1lZdWlnejQvTC8v?=
 =?utf-8?B?OHRpY1UyNWxqRkRsU04yYi9zYlZ1OGdkSUhtTmhuOS9pWTJjUERuZkZSQ0Y2?=
 =?utf-8?B?aS9BUlJGb0xQTVVQVGVKUmtMcFlGYURKNVJ1SHVqTFArZC9mSjFGVENDblQ2?=
 =?utf-8?B?NGVzTy9SL2V0RG5oTDdIUlUxTFQ5bytTVXlyakNZUnpCOXF1bGx5TXppWVF4?=
 =?utf-8?B?OXZTMDFKWUtLWjJWT20wUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QllxWU5OZ01jR0NpRmhza1RlWEJWZEtsTENobGJyUkR4dFR2VzQ4ckNCYXlx?=
 =?utf-8?B?VmpZOXBvanVCMVdQTU5Fc3Q2d3M1d3hwck9DbnJjYS9oa1hxaTY4bWdLYVlL?=
 =?utf-8?B?WndVckhxcFQrUmI3czJQaktTQ0MxL2o5SFhBVjNOUGo1amJ5ZmRFeUtvcXJ4?=
 =?utf-8?B?OVMzeXV0VjY4dHdZYmU3d1BKaEpuNHJVdnpORkhGR01qRzUvcThCUExaU0Ey?=
 =?utf-8?B?NjRacWQ2SVhuOHZ0c1piTldQMHU1cStwZDNFR0hkQTdrWTE3Tm14bGVKa0h4?=
 =?utf-8?B?L2lsLzViVWR0M29Qc1J6c0JsajEvM2V2NDJZKzVLRjA5SFRKRHlhNWxlZ084?=
 =?utf-8?B?UXpXcWdaVzN6Zk5Odit0dkNpbjQrNzg0NnhBNmhhN0dNS2lsUGVsTXJNUGI2?=
 =?utf-8?B?bGNic2pyR1hkMEdSZUJ4WlAwT1hieFgvMkxVbjd3bzg2cEx2eDlpeko4ci95?=
 =?utf-8?B?eHdCYVhzSHlOWCtpMTVDbFRXdi8yZ2lnRzlzUTlFTWx5dWxkNVhOc0N0NHRB?=
 =?utf-8?B?OFIvTHI2enMwWkFSaWh0QlR3cWdNbXE5L1pkcUE3UFRFTElLV3BMNVIraGg1?=
 =?utf-8?B?OUZVOVBZWEd3eXRZU1F6V280U0FxNHJ6K002UXZzclRiZEJ6NmJGQ3FrcHJR?=
 =?utf-8?B?cmNZUS9QZmJXNlZxdzcvekRRZGV6YmFiazJlUlMvZ0h1S013U1BETXUxMFlp?=
 =?utf-8?B?amRRa251V0ErSW4vRTNxemZaTlVGMWRna2JGZy9mT2RLeEFiVFk3M2FqZmgz?=
 =?utf-8?B?OU92NnVmVDdwSTJaNFV2OWRHME9aV3F0QWd0V2hHQVQrbisyQ1ZHc2lNL3FC?=
 =?utf-8?B?Z1FSeVFJeHgrQ1pKOGY3TjM1WWx0QktaTllYOEhVRlpBcytERnlWUnBMT3Nu?=
 =?utf-8?B?cjFCbHNOa0NFeEk2cUZTelFXdUNyTllCUi9uekpwRFhoMVJqQ25JQmJ3aE14?=
 =?utf-8?B?N2k5OG1rSmhIQ1BkTFB3Y0swaU4yTlc0Z0NmMC9kWDlsVkVZZlZlb1c1VGxP?=
 =?utf-8?B?MzgrZlo4R1djSjRQOGVFdGRDZGxWWGU5VlcwTVMrbEVsdjM4MHlkZWZmaVRX?=
 =?utf-8?B?ZnFxSUhTaVI5akszaGhIZEYyNlFVTkJTVGRKTE9JM0poR2lLVCt5NVNQK3I1?=
 =?utf-8?B?ZTZWVnJtMHZKRDJ4NjA3RzFuNEwrVWprcmF2WGpGa2VLRkZIMzN2emZlbWVx?=
 =?utf-8?B?dE5nbDVDY2dhVUFkdFZya3VkTVF4M29DQmNmVDlWcHRWQmkzdFFXUldidDNp?=
 =?utf-8?B?bnFJdzdzVVhONW43bmY5UldleG5ZUS9wbnpMOUR6SVBTM0JGZG9Pc1RWZlJI?=
 =?utf-8?B?Z1FaR2IvNU5yeENNZUc4SXV5NDBpK3paMzVYcnV0dkI0TjlHM0RabVpnZ2Fz?=
 =?utf-8?B?YTg4ZmJxeDBueERZYkxDS2V6V05wMTdSTElhNnkvS1IxZ2VsbW8yVVNBMFhG?=
 =?utf-8?B?MDdsbS9YRi95YjdRYjFoVjg4WjRNVzlOQlVlQlZVUWxqbVYxem8zcU1UWFZM?=
 =?utf-8?B?aE1GcGliZWp0eGY0ekYxUHhtazNyanpBcjhac1lwNUIwRnVEMzV4Y3lwQ3pt?=
 =?utf-8?B?ZmhhV2NJWWlHWXpiY1ovTXRWcVRZQ3R4UGJySXRTbWZweWhsR2xrV1IwZzh6?=
 =?utf-8?B?LzlKRmpQS2g2elVjN2FKYWlZVzFmM2NzeE50aTJTZGJuS1ZPZVdRNmpxcHgz?=
 =?utf-8?B?dlJ2U09sRjQ0OTQ0MXBVaHJQRW1PeVplSllYQXlCd290YzFpZ283YVVtRHJQ?=
 =?utf-8?B?dFovZnBBbkFTcUJJa3poMnNrRitaWVV2eXliVVpma3FtdXVyUmRPOWRUbFZN?=
 =?utf-8?B?WXFxZldxcVNrc0hhNS9xR2VqdldoLzEzRnFrZmxTZTdsOCtsWm5jcWgyb3h3?=
 =?utf-8?B?ZzliaHJ6bHdxRldVS2JvaWtnU3lUVzRUV29ITk1jakVqdW1Ld1NIdDdIdXBy?=
 =?utf-8?B?ekxiejVZaGFyOGpYejZZbldlMWwrSDVmUjdHc2NGZVlvaVF6SURqcmVXa2pk?=
 =?utf-8?B?SnhHVzlmb0lzTEhFc0JGYjFmTkJYdnVZU3ozNVJFQ0FwWk5ITFgrMisxd21M?=
 =?utf-8?B?bkdvTVdyRGp4dm5KT1NGaEovYkV0YXVjSXYzeGxOVGlrVlljU092clBaOS84?=
 =?utf-8?B?cDBDWTF0Tkx5N1h2VU0yUXBXZWd1eWFZb3BZZzMzVHovK3FRK1U4aVNUdnJ2?=
 =?utf-8?Q?UonS5CspxOlrEcDG0x9FAzk=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776b3926-f936-4a35-912d-08dc6499bd36
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 20:04:24.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJr6xDH85fuZO9Csgwwxpqkyml6SjK0V58/Jg2X2ZA6PpIegYMzFnZIXFVlmkSLYyn8HVukkf4O2Vr840K7t51cDLOYIOJuVtXA+tE+kz4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR17MB5846

Allows other CXL devices to access host DCD-add-response payload.
---
 hw/cxl/cxl-mailbox-utils.c  | 16 ----------------
 include/hw/cxl/cxl_device.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 413673da59..dc916f5bb3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2184,22 +2184,6 @@ void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
     g_free(group);
 }
 
-/*
- * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
- * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
- */
-typedef struct CXLUpdateDCExtentListInPl {
-    uint32_t num_entries_updated;
-    uint8_t flags;
-    uint8_t rsvd[3];
-    /* CXL r3.1 Table 8-169: Updated Extent */
-    struct {
-        uint64_t start_dpa;
-        uint64_t len;
-        uint8_t rsvd[8];
-    } QEMU_PACKED updated_entries[];
-} QEMU_PACKED CXLUpdateDCExtentListInPl;
-
 /*
  * For the extents in the extent list to operate, check whether they are valid
  * 1. The extent should be in the range of a valid DC region;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cb95ccbd61..5c60342556 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -525,6 +525,22 @@ typedef struct CXLDCExtentGroup {
 } CXLDCExtentGroup;
 typedef QTAILQ_HEAD(, CXLDCExtentGroup) CXLDCExtentGroupList;
 
+/*
+ * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
+ * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
+ */
+typedef struct CXLUpdateDCExtentListInPl {
+    uint32_t num_entries_updated;
+    uint8_t flags;
+    uint8_t rsvd[3];
+    /* CXL r3.1 Table 8-169: Updated Extent */
+    struct {
+        uint64_t start_dpa;
+        uint64_t len;
+        uint8_t rsvd[8];
+    } QEMU_PACKED updated_entries[];
+} QEMU_PACKED CXLUpdateDCExtentListInPl;
+
 typedef struct CXLDCRegion {
     uint64_t base;       /* aligned to 256*MiB */
     uint64_t decode_len; /* aligned to 256*MiB */

-- 
2.34.1

