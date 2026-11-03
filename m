Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793741508;
	b=rND/wXQsWla/HrQofM4A3gnB4IqNgGW59VcHJe+VpXifcNzfAnIQwKDLoT7+5R0NaExD
	 Eektoe38Jv9zligOhhXaRntjAoUb9u+vNeqJFujluu4sU5OT9CKbg1HERsrDes2Fys+Z9
	 5rPiVE7vgoaAlepxFoWEzfqhyhM7cDiZJFHxAvpoMWZKH5GVf/8eCOlnz/Zs3AnSHqwSM
	 dA/HSZqMlnrChnkImewkE179qj0NWUYTv4CG7lf9dn0qXJ1Ai0AIaOYhUr2vwNRIYobSw
	 ldH5udLZ+YJd1jaoyKHzZ6776lJBhMziGDoO0CGCj7dySVLYlJGt+glqDoT+2WE/XmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741508;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KCzsFnc9fCBdbApmqODIqz2GV0h3TgzhyGVnsMQ1nCM=;
	b=pP+52w5DG1xuo9aYJSnB36LntnBE4uQFdFVCWFLoKHzZHOEu7pyA4zeap3N4o2+BkqBQ
	 Wl4S9hNOFNyIQSmE1o5kNtmAxx9yCxfVXXcBeT7jPwEDdVLU6ywY76P01DPevhDoMPwEo
	 UFA1XF6X5JXWd0GJk8yXOPkRcJLVyG1OeT36kPAmYK7BZlWuksFb3j8OwV1jwMiQglaMr
	 oJfI6jFBh6rI0cae2UYZTNjRlmQ0rX3yAjpjYlVypV6KtbV9UiupWeL5Tsx8r+IV6gIzM
	 VwL7s/gw8Q5ux4tv0a/h8ngxoSTgNeRcHCs6CdtvwzrdW9U6bbGA3w3oT5Ek46exLmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eXavaRzD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C0606A31B;
	Tue,  3 Nov 2026 21:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 214C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eXavaRzD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSYYbKMeVLqMZMcDgqxWThq5FU2Gc7gDqZqKu+2zEupBSqk7TB5T48nXrnkgRla0BkNucPcVIOlBKV/faj45VpeYDjktztgG4/ZxscyXf5Zq1oe16uuVi1Ubdr197ADo+Wbr4KpZ5ryuEHL/0jmfVRMXkcW/BglLaGIgQ6Zffw4XPTyYs2lX9aMiK6afsdbmZngGLGL3trod0TNMSsS4k978SOV4SLpWOiZGwovyZ8yPcNrIezl8bs4lM/xVBieU7kpW8Gvw8MZrPSQpsmQ3PqXntadY9y4ROtbiRucD5HMbUe2/mwrb7DOJVVzZ23RcK57KDD3GV+GTv+V4KP3N3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCzsFnc9fCBdbApmqODIqz2GV0h3TgzhyGVnsMQ1nCM=;
 b=YLCUoU4Jj2YwJzCXITS9e7iVW2hI6PTM3b1Jtxhzkf4lhyQlZryEzIHg7EwpFo/6d3Q5kXCdEhm85klKO8+GrNKv957XARYrPYZ0+K3tOPMit908aFizcJqVV8QUXvrJP9mtEIT4nGqwDBs8LdfOtfajWftAAA3riMZgDpbJ0f2plCS6mlJgfbrHMmKwOyzDNVRPHPdCYdat+Xp+u3bZw8R36UEOngrS9ff0F354ZuOeRL/LEUNN947tC1dLohEzpnk5K7GJqBynsu7NjlnMxUbWDNLyPutP9UyOo9Dyf32YrTyxyISES2UV5fhcUKMyFCzUQfHCDzSy+JJXtBlEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCzsFnc9fCBdbApmqODIqz2GV0h3TgzhyGVnsMQ1nCM=;
 b=eXavaRzDRkXurB82Hk25D41ZbOZ1qyYHp0zlsZl7VdUaIBXihY7dc+PW+Mp+ACWT/kqYc33YL9J8gZQydmoO9FGlFupRfjv7bqT27Q/I9oiEsfX4TQBZyJDvv4wv5lIYZ6a40jn+bd9gMfEb0AB4ja5dE4t0YpwUjrPxTZquduU=
Received: from BN0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:e7::14)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:31:43 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::69) by BN0PR03CA0039.outlook.office365.com
 (2603:10b6:408:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:31:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:31:41 +0000
Received: from [10.236.179.122] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:31:39 -0600
Message-ID: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com>
Date: Tue, 3 Nov 2026 15:31:39 -0600
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cxl/core: Create EINJ debugfs files regardless of EINJ
 init order
To: Yongxin Yang <yangyongxin@kylinos.cn>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261102032436.230945-1-yangyongxin@kylinos.cn>
 <20261103053618.884065-1-yangyongxin@kylinos.cn>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261103053618.884065-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d3db59-4fbe-4b35-1ec4-08df39f1d9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	YtDQRSzoiCHO24dNjkApuWWsBFdnfYfLc8syewGh4pp833qex6UGBxDY3U/1GMT1vTDzvTFBI050uDrRXpbT1b2l+bsDaJP2AqB5LDe6cJMdDBi42mutC1OPEtF1pirNxKoYivdS5B27XfqIMkSf8ka5P8N8x2JJ1phaYeW6mXGH2I4EdtXg+b1nmkciSuBmCojd806L/Sv6fXmEecB8fV+7aGYJoKwj06W7avqeU21SykghbDMnUOhQh37hKNLG0rOU7YgRNFN19/mUThDWcUvpdoyZpbvn6nhNK+C7ZKvDr1gZxgojRMlQMgw8AnCAJdSH+x+IzLbxUtIuNWX3yl9SjyTf3gdWImOvRabnVZMsZpFjU2kuM1aQw2/Tu6eJQJOOdA6LjbDCFsFJtdNUryW5pcV8CJ8BRT26OueLdasQOLMDhMLnAf9qZidXkvjMkpb+DhrPzwQ0Kkh4MPvkmpNuHIw51URMNkt9jYNVOD1TDE5wUoISw2UPRbCWsLfuqC4iHqgvQdPO4PHlX++mc8EnlCQQSkLw2W98AGsWRhU4oSZlpJTc7TwXHefz89yWXCdhYk/KGtrOK6EfGE40f+pHWwRW0dVnz8TrKrsws72/UtGkFcjA2E3JMWsz0Bvdbx83LFiMq5NeYwlR+rdpLTf/EokO8JGGB9puoNo0NRVczE88bbiLojWMNC0QnmNMj/+JZPwM5C3p09fZGWA5wQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aVTgvrLsewECYV6FgKFcnSnY7sINmUAPRZlIKc4nIEzCkf77Zx2KREkGQ7mkiZLHpNrNOvbCpda4DIDJWqbOta/TaDetGXaICyM1YsDQSZdoZqm8EavHuV0O8STz79xY9OIfQOoJeIeRXPS337REc7/P9TRggY02soAZM6CXsy1AMjfHprHJ4B1ogY4DmO6AOaWdr/R2lCYTaqLWTZGqGmyGLagVljbsjrUFEcIHWhH0AIMek9WcXjqIIMhVktxUWhYYjahSY1Nt3AaoPhMnLzVK5eH8DcqIhnTg0cDyqR28ru4Pa/OnSUHCZ0t0ZrjdMpNJidqrJWF/cw+N8G+0IwmvrEEAOeewUUAH6cgYoyiYhAhR3GWNt675AMow8Zb3n7fHCmK8xrj/HCQxSf0XcoO7SjTMSWnWYUFOorxZqqeLlpOTnTGNjaPGixhlWBk4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:31:41.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d3db59-4fbe-4b35-1ec4-08df39f1d9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

On 11/2/2026 11:36 PM, Yongxin Yang wrote:
> The einj_types file under the CXL debugfs directory is never created when
> cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
> einj_init() registers EINJ at device_initcall level, so the
> einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
> up yet and the debugfs_create_file() below it is never reached.
> 
> Change the file creation condition from EINJ being initialized to a compile
> time check for ACPI_APEI_EINJ_CXL and return -ENODEV until EINJ is up.
> 
> The same check also guards the inject files under every downstream port
> directory, not just the RCH ones.  Gate that directory creation on

That first sentence should drop the RCH mention, it's not relevant here.

With that:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
