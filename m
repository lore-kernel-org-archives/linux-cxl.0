Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844B371053
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139743; cv=fail; b=C6DDLo77pnG0CPB+Rp9rRlox+gaxDPHa+35XyxDKm0UTDYUnFk17hrR4cm0BZXRUg3YlsMFuwwZZsciB7fZJ5BxYoeGPZH5B76w+/k8HPY93YQZHUuW7Y2r88SNfXaDSNQVE+TiTJVByK5MD8WXUK0zMuWnqcBe1U6S8nicJV48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139743; c=relaxed/simple;
	bh=PRs91QfGi3COtGzfySiFnVyaffUu37gbgTVDF10A1aQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Q1X2ptMWw7hLPDAQX09shXeTdljcm2zrv0QVjFwrtnTNBkyG+es4tAxDXfEhjlprBRxyB4e8bEzOSo4tbjPILBPckZEiKeCdRk1OHvwM+THUXyYMaauBQckKqdYZJju0OfFa09DNBhMk+cy3ZLsbcv4URa/7HKIh0E9jmQ60tWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t6NMRIvo; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t6NMRIvo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wdye9J/lmja3Hw/KU2Orjs1tQgxJofzrL4JMz62w901UQmsBfBmCZodf/ucNtFTi2z2lcIiPceBUWyXYfiwLx8dH33WcaZbINTbv6Afm1fCJAG4UbV0CY91FXBMpygVPXnb5HO/ZYgQL44hRCqfpQ7WKOh6owe/kkRMijFGOK6ijP8lXq3ayPi7g4YSanrABkgwgo24gN+SMjjJISQcvgfaiO7Uyg8eyUadSSa66CtWeLna4doQKurbeivQRc5SBOpTqmYCMUe4poFzaOejiKqRH7E5W507f3z/02mItC89kcOxPrQVB3YLw/KNkJwfedymXku3VHtzvtJY2FvsdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/Z1AR5/6kO+CJS4TutNtHGIaqDLoDgpxLHK/681S2g=;
 b=MZ8EJKer4y8YiF7JPWcG6TGkwItpV/ciClXM/urLODzOuuN5ZM3zG1ze2d9z7PJGCgEDwcl82vQ1QukDydhoDiSRKrILR1tszwMg0Qpx7FQheBfDO4xO+KBbqTkRRks3SRKId9GpA2AE7s7sIpA4MD0hMwXUG8PqZHLQS8DfISQDcqM9N091y5AlkfI30dm2aeBA/ztPHFC6nJWYg9/4UGsJsohtzUL86Nc/Ec8dnkzcc20c8xzqqCmzrNZUgIHD+mGa1aCuzw/V4St7taKFV8e8kl/B/Xu32Ns1iufNI3wAzXDSpi0QQ7t2YoAC+tPX78pYAfugXXHONJIP28occw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/Z1AR5/6kO+CJS4TutNtHGIaqDLoDgpxLHK/681S2g=;
 b=t6NMRIvoWxvH6nKBZKJPslniDZC8B2HEf0bCbFJRCNilfeHMom+PuFIFNddy7kXNxYHY76hENr2dDs5GouEZq97A13Eou22RirKlMOo0OsUQAzJJBwXl4MnNwENrW7p+9j7agZ8JeLg4s5Hp715h3VqLetg6Hxl6PueYrMyy7mE=
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 21:28:58 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::2c) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11 via Frontend Transport; Mon, 18
 May 2026 21:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 21:28:58 +0000
Received: from [10.254.60.74] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 16:28:56 -0500
Message-ID: <3571c210-52d7-48da-9307-155cb9ef66f8@amd.com>
Date: Mon, 18 May 2026 16:28:56 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 3/5] cxl/hdm: Add BI coherency support for endpoint
 decoders
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-4-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260516022037.1761453-4-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f8e802-7a5a-443f-f0e2-08deb52478c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|11063799003|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uA2+Kyzwi9TPslYF3EgVYld1Z7KXKoTntKZymDjx+jrsHz3njHi/0iVmfAV6Ae3QSa63/7AsrnvIqXwuvJHXIVn8yShgivRruTh4WMQY14WTezAUG4HFo4MSyAAwIozNAH/39W8G+gzOR6gcZBigrXNpGRLdSFrhPTEDM0PaWpMh2YUnA5b8dc4yrkZi2lcRGQOaeMYKJOK6PUsSyg7aQOMI45QAFlrTbPvhRRTifAw9gOXPtgnNshUCbKT2ZQLxpniYoKBJLuka/bKBPdTvFAtzw/1wSH6Lg1Gilnu9c458LW66pa3/ghsBbAgXAXBPEuR4a+eurzgRg/QSf/OPG2cNc8+qjq4GmGDJ5xd1jRx8/sCGgrmZFy3VyN6ZYrJYNsbObfSlcF3zV4wfeXCDuR1hrLZdqtqZAd0pRvBNad53Rw//FHw7qrWsMdF6yC+niY5OoqaMXFQmK5c9pn2LfwQziEAPtzl5Ks32U8KBGyKr+4W8ryzEuHgx7nPuVsaRoEV77VNi82heper4F5HDaUynKdpuFsJ066acxAvK0kKxMgRfPI1QzGf1ffMjkHGXBB9pEvMQhCYYd3NlvHTgHnaP6HhreMyNlRqSwvOvnWRaN0pBy1e1LPSqRDZf8v8P6QBQqoe6+7l6JEeejqDfrxGCX1TFnvoSOZ5o8gU6AhGRrY44HWbEEbIR48gbkaIIiqBBX3+q5TEbEwvKM6iul5lopgJIVXyHfYk90M0iv24=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(11063799003)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8/4sReQuXatLM8oaVjblSP18JAiq1qJIgVcDKGfsHHFoMKy3QLxO7in9G4jqRNIl+UU1K0HyUaz9iIWwSgmb6aiEN12IhBr5KDr/bQmWizxFK+s6haGT3ZENb7oQqLaosIXt8zMpz1X5F7LZHJSNZnZIel63Q+9cFwC5r1IPXmv4nVeLxVIsTHjZAIuI+qXUevLzGW8ENu7AOTyxud5AG6xUpZ2ABwotYCOSydThq4O7kVqWeqXKF1Vu4DT+j0T3Xzui8i+T5E/vQEutSoJHNx7Adw8c7JJzbHP9krNPfkDSSa3k6nOGKSrbs1qujEo6Vb6A6draqq+YMbt2MleNEmRevF3+293AFxqD0kPZngL17ISPr6VNJdPeEWHo46rsJJUwmqnBCoCNCN1r3gR1sUxUgsCj+doYOQQ8WME0ZgnNlzRqOfKBoo+cJGb/sm+J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 21:28:58.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f8e802-7a5a-443f-f0e2-08deb52478c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246

On 5/15/2026 9:20 PM, Davidlohr Bueso wrote:
> Add cxl_dpa_set_coherence() to set an endpoint decoder's coherency
> type, validated against the HDM's supported coherency models and
> the device's BI readiness (cxlds->bi). Program the BI bit in the
> HDM decoder control register at commit time.
> 
> For uncommitted decoders, init_hdm_decoder() defaults target_type
> from supported_coherency: Type 3 devices default to HDM-DB when the
> HDM is DEV-only, HDM-H otherwise.
> 
> Pre-committed decoders with the BI bit set are not supported because
> endpoint and port enumerations are independent -- at decoder
> enumeration cxlds->bi is not yet known, so the topology cannot be
> verified.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

LGTM,

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

