Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA08F58
	for <linux-cxl@vger.kernel.org>; Thu, 24 Jul 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380060; cv=fail; b=Xiqx3ChuzdE5lu5mqjUgj/Re7iIq7zguHm0KWyop0BTwZf5KXh59JxoriX0c1EO3uY2oCyeOE5ZDYhMGhFuE0yqKrOz1rIS+rARTVHlwoMC2RiWEK7Eyf/QyUw3pjOXZOGPAbvSPxrRPb75vyEFAn7lcIPunSZ9PUlZ2+CXFHe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380060; c=relaxed/simple;
	bh=VsnqluvA+EItM3iDqIF3QwC1h9zwWY24ZBF4j9+UM7o=;
	h=From:Date:To:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=PaoG3H2JUhL2/WYbPKjwy+Mkqgep/+rbHNK5FI6nlUEp4o3y+uAzi6LrJzkw1gMLbjhFuC6nbi3CKV85nB5N2NTdA7tmzdCX7xz5ei/o6jKlBWCjiizRnWNdBwq9Uiv+FU4SW03xULM9p50G016DKhY69uRwOYl1T3KNUs2Mq24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akL/u86W; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akL/u86W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753380059; x=1784916059;
  h=from:date:to:message-id:in-reply-to:references:subject:
   content-transfer-encoding:mime-version;
  bh=VsnqluvA+EItM3iDqIF3QwC1h9zwWY24ZBF4j9+UM7o=;
  b=akL/u86WZJRR7hSfAG3pM3ectVenD1AxoQ0Rw/7JfYcx5NbA9d0uOBLt
   PiQcSxj1Vjo2JNrnwOXnSzcZB7nzf8C1vjJ/3w/cXYq+jg2g6Un7fJDN/
   7L6a/DCjZZO8PLiiBn3NtCeBOpIZPyOmJ2pWPezgtfq1iy4jBuOP4SKQX
   GNl7qwCP7FusaBHoAh9FTw9BEj3x9AI/GFlOBy0VWl1mqEONpFfEF0mVP
   u3N4+Mlo3TVQ5l2hmm7FqMAYr27T28OAMRdyGSUhn9IVey2TL9zmt7Qny
   lHgJjJfm4QVUSetzQyF9VJfrnXb53NV0zhfZ+QREiL9lx4QM8uu8yz0Ia
   A==;
X-CSE-ConnectionGUID: UBmVfD7cQ/el0d7PVd2tyw==
X-CSE-MsgGUID: a/9m8cpXRgW6j5KbgrBC/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55411410"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55411410"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:00:58 -0700
X-CSE-ConnectionGUID: Ms4f6N+BTACItqNf2vgRNA==
X-CSE-MsgGUID: SYYciLvPQBq454Rx2n25rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160128311"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:00:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 11:00:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 11:00:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 11:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY1Cq9RP4q3l3UMK2v4GESxcTKZTHhz6geQDqDPEtbdGXSQNOIzb+4cBHq1iRVn9xGQ3C/0CSZjHg00xnCHk4LDFbkOqPeVLIC4LBruA++ZoGXUPWsGpBuqYSxxaliOkV3vON4mSsJvFvcsLlFdyUYAFDays1cMIxczMTsPPfDuqlM6GqiKAIeGaMvEHMoVg1KR4JdcuuqqCOZjqmHx3ucQ/c2CO8+XYT1dOmt+TuSVDOE9Deul0IUihiUIXyKO324oQFpCHxrkdGfMfxOj7bZgJ1F4mj1VoYrbr6K9gnGm8zZ/JWGOlariubAnq7C7UCFBvylXEK3pEe3+UorUVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBuGAiO+jOaBGLd+/npL+0J9bDouCg2z6Y9RdUqngGY=;
 b=JZfjIZZJ5bHIO2U6p8ssUTxaB4dAecVBKUzdiXBT3Z870nvPUxTqqHmZcPfLmlBQ+OGFur4pc8V9Nc+3L+93XNNHm+a1i2lu3vabZp6aLf/6R5NVRGnxZQhb2Nbr+LSimag3MqsW1RIf/jrHBT+sgoVGL4+55drec9m+3y/gZH0SvY/d1F+ILI+HJKkkldx1C3TFj5tr2TcJB/J/SJKsGT2Bjw5g2EocoAq/XaCD7HLVO0euKdbzqgo2fF2+bu3Xj0ayOdsoagpV7xu7s5KgWxxTYt/OuwcdIWHsm6WuOsg2hw28R6l+svWdSSspJJTlevsThYuiqGnQpTrgZvwVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 18:00:54 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 18:00:54 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 24 Jul 2025 11:00:52 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>
Message-ID: <688274d46adc8_134cc7100e4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <4bcbde9e-8795-40ad-b948-56721cfcff8e@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-3-terry.bowman@amd.com>
 <6881626a784f_134cc7100b4@dwillia2-xfh.jf.intel.com.notmuch>
 <4bcbde9e-8795-40ad-b948-56721cfcff8e@amd.com>
Subject: Re: [PATCH v10 02/17] PCI/CXL: Add pcie_is_cxl()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|LV3PR11MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: b8155637-9ec7-4255-963c-08ddcadc08b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzJuNEZvN2hJWkRVdnZ6NWwvbDhVdmhscFFzNDNsaGJYZCtqWVZTWVY2S2M4?=
 =?utf-8?B?S3kxQjJXcVZxSzlzK0hXMDJVb0VYKytrZHVmd3lFYjhFOUw5VTc4RUFEbG1H?=
 =?utf-8?B?OXRVRnpCQVVaNENRenlNaDNlWXVnd0lmbUhVZlJHMk51eU1jam5xME1RTmtH?=
 =?utf-8?B?NGQvekNoVlRtNXZSdmM2eWV4N01hOVZaQUw0Z2UwQm5OdjZWOE04Ti8yMXRM?=
 =?utf-8?B?KzZWVmNRTW5XdXcrUkNYRS8rVjhkdGN5dHkyeDhkQnBUVmVCanRXSUduNXJs?=
 =?utf-8?B?eVpPV29FM3NTZmZQays3Qlp3RE5lYTBpTmg4bklZU05MREJnZHU4c2JBWTJz?=
 =?utf-8?B?TnlKM1pqNTM0WW1RWVUrdEtpN291Zkg0R2RqcGpmWU5MUzVRZWZMZytVall6?=
 =?utf-8?B?NFVUaGlZcnoveHQrWVBsd0plVXQraVA1U1haK1liTDBJRUlNMlJsRDVPdmE0?=
 =?utf-8?B?a3d2ZklEVzFra1Y2THpMcm4zbm95YmNraEZnMXUwZ0ZjdUdKVFJzRmZVY1Yz?=
 =?utf-8?B?Wms4N2txbnkxKzdrN2ZWZnNsaHBXb3F0R3pJWjVzTm9HZEltdXFDRWpVdkFN?=
 =?utf-8?B?WTBnL25OM3Frc2lpSFdRWEZqaERBRU91cTF5WDFmU3JSbzR1QTZzMlNBZkt4?=
 =?utf-8?B?NHpOWjNJbFRRT2oxMWR1SDFTQWsyWVIwZzUwejgrT0F2cndOV0FPTkljWkZX?=
 =?utf-8?B?alFyQ2RnVVNSL1p0NmxHSHVPR0lxNWhBVGwwc2xBeVMxUDVnUXdnUzV0YmxR?=
 =?utf-8?B?bkZvck9LbG8rcUNySU5HOHZ2Zy9FYndjK0RLUC8vVW15WGhtNm9NWFBIMUxB?=
 =?utf-8?B?MXNBb1pTenA3T1JtM0NlL2FzNXNieEpmSGRUN05qL0ltRVVEblJLUWZSUnZ0?=
 =?utf-8?B?NXg0alVoMDJTd2g5MDlsOExzQjc0bWZrdHZMendWOVFYT1pTZFV0dXJZdEI0?=
 =?utf-8?B?dksrZUFmZ3BmdXVheEhwRXBtMkFwOXRCd3pzUERwZ2lTTTVSMmtuTUVJMEFz?=
 =?utf-8?B?b3JSQzFLN1ZEZnIzUWw0RVFQWlRia0JHejRleW1ndUlQazcvSWZRS2s0bEdV?=
 =?utf-8?B?bEkwbzhOc2Q0N1hBY1ppWHUrekdreFlhLzU2UlZIWWxKZVRueCtpSGhHRHZE?=
 =?utf-8?B?NzV5bU9sMnIwNmVyQzkrTll5QVUxMFFaNCs5UmNhVyt4ck01dUMrNlBDMVlm?=
 =?utf-8?B?cjJlRW9VNkpjUjlqaEFUSHQwTVYyMlMwTENkS1ZwdUx0dEpreUMzQjlEZjcz?=
 =?utf-8?B?Ky9XQ0p0aHVHQTZUekVlOTlGUzhUczNqeTE0dXoyblJzZlRSakN3TVIzSUVD?=
 =?utf-8?B?cWI5SXdOeSsrWmk5eWFnejZhV3FZTGNUaklsZkJuU2sxbXd5ZHJtSTFiakZH?=
 =?utf-8?B?Y0VHL3hTY3dOc2pQKzh5d3dQOTBEd1dYZ0M3UFVnRWtsRVJCUm5Hd1JveGtK?=
 =?utf-8?B?T3RTUTlDQlQrUHYzUS9nRnlLUTZ5dVE1T3JreXFQTWduR1R6S1JwNmI4WXNu?=
 =?utf-8?B?anUxa0pGanlzbVBnM3RYa2E5YVl0NUg3dlg0VkV5UWRPTHZWYms2N1pmdDBQ?=
 =?utf-8?B?UXc2d0JVV0R6TVV4RnpIeFhhbW1vRnRBR3JHUS9kb3h4bng4cGlqMDVMdFc2?=
 =?utf-8?B?djJVcTFxZyt4d1pUNU1NdDVRWVFLWHZlUXlSQVpTUGNEc2tRU3IwamJIYlZm?=
 =?utf-8?B?OVNlWkVOZXFuV2NKWWxDL1JmeUdGNWthVHFCVDBQSHB3TnA4MFY5aVl6bHZ6?=
 =?utf-8?B?ZUR2UnRBY0kyb2ZvSXJvektXcVNValRSY0pxZi9wanBmQnJ5SlRTSTQrNVJs?=
 =?utf-8?B?Y3pDcU83SUs5c2lPZTJsNkZBSVNtc3FndWkrcVpoWDEycForbGNUaVlmQTFK?=
 =?utf-8?B?VlMwczJvNHhwQVluRWp6bTlOYmtUc0lrWGpsbmFLczkrdFVLYjZVNDhQM0wv?=
 =?utf-8?B?dWtIWnVuOVhmeHhsUW9KLzU0a1NwS1BTeHFhOC9sa2RnRVNJZUxFeGg5d09R?=
 =?utf-8?B?elFYQ25oemlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3AxM1JrakhqTmt4M2dvd2JVZ29CVU5IbDJQSUhYTDZzZkdocmRXd1NnR0Fz?=
 =?utf-8?B?a1JpK0lZcjZRU3pIREUvVGIzRnVqcmVLQm1OWFQxd3FMY01PNEFiMW1tMEJi?=
 =?utf-8?B?QzF2YmFqZDRXNHZVRnQ5Sk5rT1Y3T2NrYXFRQ1FMWVJzbVNHZ1dtUWNCL29t?=
 =?utf-8?B?WmtJM3V4dkkyVGEyMDRyVFdTelNHQUlYd0QvOUtjV3dLMG1jRDJVbE5YY2kv?=
 =?utf-8?B?ZUZHR3hlVS8rVm54SE9vcExrS1VORnViOFU2bkJHUERzc3pLaDF1NU5kU1Vq?=
 =?utf-8?B?RFg4bk5XUjhHM0tTQlRKdStERHZDYkQ2Z3RBVFNMNVdVVGN6bmxJZStZVU45?=
 =?utf-8?B?all5S0J2TXFYbVc0dVB2KzkyVG1qYjBTejE0QmRtVEY5clNRWUZSdUJLN1lx?=
 =?utf-8?B?OGVycGhCUm9zemQwdXhPNG1TTTIzQXNzM09MRjRqVEh0cW5nQXdGejgvSnNC?=
 =?utf-8?B?NlFmOEs5d0pES1FnY2NuQm5TTHNhRkdZZEx5UVpLYWV3K0kyTnNrS2RSWDJ5?=
 =?utf-8?B?cDg4MUVqbXdDM1FOdWl4RDB5YzJmbVUvT2QxZWRqTENkcXNWbEtnK3I0MjJ1?=
 =?utf-8?B?djh6c2M1bzlXQ3lVRlIzS2hkbE1QTnRGd015Z1BnWWhRMSsxeUpEWXF2VDFE?=
 =?utf-8?B?ekY3bkpGYzFXTmtSbkZaWmhxOFQwNVczNDJoWmJZYW1VejB5cFNENmdmNWdD?=
 =?utf-8?B?UXN6K3lRUWpUWms5dnl1K2lGd21mSjdnMmJKbFAzTUd0MGg4NjgxUnQ1UEM5?=
 =?utf-8?B?MVhwUXVQdnk5NmtyT0pXdmF1UzJGbFdHdVBoeWdrb0g1Y3FBdEZXZjNXTjVo?=
 =?utf-8?B?N1M1KzcrbU1uUDgvYXVpcVlhd09VZlIrWWhlVk1jcFRpVEliSDkySlVqcXdR?=
 =?utf-8?B?VTR1YmNXeGxFa0d2UFhaQ3hvWUJqeWJyU0hza242eUpsTnRPaFBlaVkyNkM2?=
 =?utf-8?B?Z2pSY2cvS2pGTG93WlNmTU5FKzdYeVBIeEhvaHI3UDRXYzJJVWhkTFg4aDZO?=
 =?utf-8?B?ZTl0NlUvbzllQUZDWE1YVU15VXpPb3l6L0pueUtlWjhFVVRxT0hSN3hiamg1?=
 =?utf-8?B?Y0U2czdQdUdzNjdFU0U4M0piNWVZSXVVUTJhMVZLOEdaTEhNWmVxUWRLMmpS?=
 =?utf-8?B?UWJheGJqSDFwRHNMWGFTeGZsNEdVRG1aM2tCaUk2a3FFWU5EeUNaWkNwZ3dR?=
 =?utf-8?B?ZlRCY050UDJpV0ZyNTZ6bXgvWmt5MnBSK0c5L2hWSnBUM1FZa3FEaDRxakJm?=
 =?utf-8?B?dVNEcENuTUNyS1BtOURtZFp4Qnp5Tkd4TTU3L3VmaWMyVXcrcHB6S1J2SEtw?=
 =?utf-8?B?MWtFMU94d2NmTGdpNTZCTUM0Rk51WGZJbTVNT0ZUSU50MnVJZjZ3K3Q5N2k5?=
 =?utf-8?B?WTJoSHZ2WXJqVVdKR0IvQnA1U1NGUUlLYjEzTlNmOFVaL0pFeU9yczRIVEM5?=
 =?utf-8?B?SWhXeEFpOEFJWkN4b2xSbGR1SzJCemE5WkpaSVc4M1EvS2JnT0NlR055MVBs?=
 =?utf-8?B?TTc5VnZiYTNuaDJVQ2pEUnliNXJ4TTBya05FQTdVVDRnWjRpRHJEeDZQVTNm?=
 =?utf-8?B?THpXbXI5K0tVN0dXUTBCNEkrMFNtK21MclBRM1VNdzVzblFoNW82YnczdUFB?=
 =?utf-8?B?cUw1ekpxSmp1ZEp3bGxYeU9jZERrYWxiV2RLZzFsZWxnL1gwOEpvTkF5ZENN?=
 =?utf-8?B?dklPQ0tpbzZha3VEOVhjZURuaFFBUVBwemRTTlY2SE0vTGZXblZrb1A0VUQ5?=
 =?utf-8?B?ZTd4ZVFBaTZuYlg3czYzeFkwSDVlMGUrbE84RGYwUXVOTGk0cnpqaHFKM3p1?=
 =?utf-8?B?QjJ3ZEs3Vk1ickFJeGNyTmJQTzViOCtwWGJvY3l2THc0WjZQTDM4blJqSS9C?=
 =?utf-8?B?QlY5SDF5d2dyYzM4UDdiUFR6K2dnRDBUZC9aT2RyNjFwTm02V1B0MHoyT2dG?=
 =?utf-8?B?WVNucC91cXBDZzByK0kya2dPSjVvK1B2MnFzNjAzcXcrYk1wOTF1QUJ1RlI5?=
 =?utf-8?B?VlpjeEQxTlJwcy9RQVM0cDBYQlpSbnRhUjBER0s2R29rTnhMSXNrc2tDK1gz?=
 =?utf-8?B?NE90S2JaSUJXOFBxMVlLazdRMHFqVHRpbzB6Z25tYSsrRUpxNmsxT25nUE9h?=
 =?utf-8?B?SFdJZWFLeFFnL0pOZ2RrTjR3REV1K2JISHNZRmZzNWpaR3Y3YnQxVEkvU3lN?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8155637-9ec7-4255-963c-08ddcadc08b3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 18:00:54.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGaO9PuEfFVN+dv7s/GYdqiQ0Cl2sqQuZuxIJAO4DcKghsNvB5M5Qi+CMYla9vbIdsf7S9Lc3GbcwffUPxyIEFYIeV2r18lXwFnGdkYbMgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> On 7/23/2025 5:30 PM, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> >> CXL and AER drivers need the ability to identify CXL devices.
> >>
> >> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
> >> CXL Flexbus DVSEC presence is used because it is required for all the CXL
> >> PCIe devices.[1]
> >>
> >> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> >> Flexbus presence.
> >>
> >> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> >>
> >> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
> >>     Capability (DVSEC) ID Assignment, Table 8-2
> >>
[..]
> >> +static void set_pcie_cxl(struct pci_dev *dev)
> >> +{
> >> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> >> +					      PCI_DVSEC_CXL_FLEXBUS);
> >> +	if (dvsec)
> >> +		dev->is_cxl = 1;
> >> +}
> >> +
> >>  static void set_pcie_untrusted(struct pci_dev *dev)
> >>  {
> >>  	struct pci_dev *parent = pci_upstream_bridge(dev);
> >> @@ -2021,6 +2029,8 @@ int pci_setup_device(struct pci_dev *dev)
> >>  	/* Need to have dev->cfg_size ready */
> >>  	set_pcie_thunderbolt(dev);
> >>  
> >> +	set_pcie_cxl(dev);
> > Per the comment in the header below, in the case of upstream ports and
> > endpoints, this should walk to the parent downstream port and make sure
> > the cxl setting matches. I.e. with hotplug the downstream port may
> > transition from not-cxl to is-cxl. Update downstream-port parents at the
> > beginning of life of their CXL child-devices.
> Ok.
> 
> The check you describe for EPs and UPs would be in is_cxl(), right?

Hmm, no I was considering something like this:

static void set_pcie_cxl(struct pci_dev *dev)
{
        struct pci_dev *parent;
        u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
                                              PCI_DVSEC_CXL_FLEXBUS);
        if (dvsec)
                dev->is_cxl = 1;
        
        if (!pci_is_pcie(dev) ||
            !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
                return;

        parent = pci_upstream_bridge(dev);
        set_pcie_cxl(parent);
}

I.e. whenever a new device is scanned there is a chance its upstream
bridge's CXL link has changed state. There is still a chance that the
kernel sees them out of sync for a moment if the link is bouncing, but
for the happy case I think this closes some of the mismatch gap.
