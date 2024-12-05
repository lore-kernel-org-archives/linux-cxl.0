Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A3EAC5;
	Thu,  5 Dec 2024 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733377523; cv=fail; b=ngeCcuKI4i5GyX/Y7t9+fji7oyPnhy8pPn6KRMwjzzHZgFz5sfXYnit+5RYnSmc9NbkCZkjnylJOlRoz2ci7DkkZ9sPdJyL11pwMgzNTYK2tkO+5cj1WRKjy9fTa/ICy1STZHFy+i4PfFeHdUpyyx4zZWKK6x+Nv7r3Dy3hqQCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733377523; c=relaxed/simple;
	bh=Ss8HokStdqgM3WxrIMFoD6mJgjwKL82wt1vriqqBzNI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRwumYKkAzf8Prd9FyZOzCkbz3txDI44p+LeJ64h+kNzsBtqcqKOQrNc/U/WhH+l3AVk7lv90mVp1LSRYkQEdRt6nP94RJ+Jy+x/YTwBDN81iR/y64LDyaDB8+u0jbsY6zc6iqMB13QhtzUJOZHprrXZmBBB1GZeE8IUij+Qt3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xjZ/cb0Q; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xjZ/cb0Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEaOkTK/UL4BpOALS5eqEnpvYrBGyqQNxEPtRC5+pZTE9fOlY4MhJ2BcAp8QipFbVcI9TeoCjrG/mUN01bB8sqNJZCLHkq5gMm+WcP/o2AfhmKroXYB5NUiXpWcXlBes18WuQ1SNtxeJisIXB/s4Kd9wIQ0ufjfMgcEoSNDdBCYjIGK8gGkBAYUaVcjl5rkV9NMGZHGnHriZkXByox/SgeZjL2upRJOVU5hUEqtivnto+OsnxqEk92vdsgsAmnzqWfDmI+itEiMStNyKWNyaMFvwXt3SQfsEBM8K9JSm4kFeEUz0Bk3cQMInInCoFv5+FtW+QRvKpJSy2fv1Q3oPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfG3aSBxls4vjkRaBd8EWQ8GW4SP1XUEgEnmh+wZdOs=;
 b=X8vFA31dn7v7Su+vUXV3Uo86CfmtuI0hOzTDQxnPASwCgg09ijzGiVnJSY4Esy4jiv2YuTRjXtqD5UrrGXcdtlLjhMBB0PhDalKHznvqDJBKyISp7izkv3SyfkloIdbunWZ17OUcHBCQ8HWvVah7HffV9s5Oekt04zHnh4GNbskaBCxYmHYcPpTTAWVkc8FOvxeyg4aLgwszGIVRxi5lS71EN+2sWJUO/sAxxEQQZAielpWGy444IYN1LsXHA6dcveu9IwI86LXU4zcj9j0oztU4ncLNRaJd4MvY9Uye3HFtPNjKgGf/VLVzYo6lJaj6m5lK5lLgvdvFpBZSmzjCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfG3aSBxls4vjkRaBd8EWQ8GW4SP1XUEgEnmh+wZdOs=;
 b=xjZ/cb0QMDciq+MpPclXl9N37kxue4AhD2RhdGfn9+fPPuTikcfg0LnxkUjCDOZBmf8uqPIC76tYPgKwARWAHgolJlDIXXUxEDvTgkaY3+Ma0YhbAFl/0RMK4VMc5ml1HqHtlHKLLbiSlTEe2tGZK8prctOV0G4gqxi0c1zW01A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 05:45:19 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 05:45:19 +0000
Message-ID: <557a7deb-1c38-495d-98d0-b1b2a008d99e@amd.com>
Date: Thu, 5 Dec 2024 11:15:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
From: Raghavendra K T <raghavendra.kt@amd.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, bharata@amd.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
 <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>, ilpo.jarvinen@linux.intel.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Fontenot Nathan <Nathan.Fontenot@amd.com>, Wei Huang <wei.huang2@amd.com>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <87frn5wac3.fsf@DESKTOP-5N7EMDA> <Z08KiPwwiw72Vo9R@smile.fi.intel.com>
 <87iks06w17.fsf@DESKTOP-5N7EMDA> <Z0_F8EuGpxPPytFM@smile.fi.intel.com>
 <8fdb21b6-5ea4-4be3-bfac-901ecd638897@amd.com>
Content-Language: en-US
In-Reply-To: <8fdb21b6-5ea4-4be3-bfac-901ecd638897@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0027.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::30) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 852732fd-a876-4eac-fe2a-08dd14f00069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjB0dlJxY05nT3J5VVluRExUbnpFYUJBVWJiOEpPSS9qUVU1aDExZmZwaUpk?=
 =?utf-8?B?bm9zWmtKb1AwUlRrZGtyZlZMdzBxVnozY25DaGdic1BqQzJaNDR1RjRCS1kv?=
 =?utf-8?B?WUE0OXp2dWRoK2dzU3NkMEdXVUZ0ZnNQdjBGMnpocjlNWWk2dk5nUHJuOERS?=
 =?utf-8?B?Qy9sbW9heERHMDdsNGlvVEQwYmVQZGJ1dDY1QlpzM21SV3BnTitOMk1Gbk40?=
 =?utf-8?B?R0pnejlqWVN0T01rbXFmZjF2Y3cxdTFvK2d1UU41ZXp5OHJDMDFWVjJQN2U5?=
 =?utf-8?B?SG90MGROQUVienlVcC81SVVJQ1YyclR2bVE3WVNCK2dQd0p6NW9vZ0xkSkZn?=
 =?utf-8?B?M3B5bnluSlVZcStJbXB4R09mVTlZMEhsdzJEbmk5aloycEd5c0JMZ1Z0Z0JN?=
 =?utf-8?B?SlJrRDBUaFp0YTc3eEhjbWxZQjJLZWgyTGpPWFlNeUREaXRoL3lKenpYMmxq?=
 =?utf-8?B?MDdPQThWSEoxb0k5ZFIxczNUWFpnRlV1bEF3SGNUSWRkS0dlYWYrOGNhVXVE?=
 =?utf-8?B?WU9PSEVKZFVyTkN0WEFxbFc5QTdheVRKN0RTQWZOZXd3S1ZuNFVCNEtQSW1C?=
 =?utf-8?B?S0hlcHVTSXRObms2SWgxampjTUQzSXRZY3U4TEV6ZjRpYW13c283ZHlCbzVB?=
 =?utf-8?B?dHpScXByaTVZdUdPMzF1MHNFQ212S0hxTHBLRWhaWkhtemZFSkVDZUZjRHQx?=
 =?utf-8?B?K3FlTUZsWDRZR1VSbFZzY2F6Q3E2Nk1Va0ZyYi9YVERiNjd5VWpOajE2UGJR?=
 =?utf-8?B?WWZJZEorbFI4bE1iTzhWVVFDcGQrNnpZcnJaLzYrK3V0UGRtcGQxSFhKSkM5?=
 =?utf-8?B?Ni9vam9ITTdhY3FFNHFWdDRhdFVhVy9FeUxEZTJQQ3BUMXVOSHNpMWJ1cHFT?=
 =?utf-8?B?dnhVU0xUb3BDcWQ3RUlqUVBCTFdOYzErZHVrRnBpZG1lVE5kbGNKZnVqQWRS?=
 =?utf-8?B?UTBHcnk3OHJyRFRITzFpWHoxWFROem1WeGFEUkNRNVVaUmsweDNYRVRKOUY4?=
 =?utf-8?B?dGdqWXhpbEdQbXVid3Ayc1F6bmJrdGREc000NThnVENaSG1pZXJrdThyU0Jo?=
 =?utf-8?B?ZlNkcS9WRmpIdGVUM2Q0Ym14bk1uMWwvNVBiWUxSZGhvSE1VTjlNbHltVEQz?=
 =?utf-8?B?SS96bUdqb00vMFBqRXAxYXdGY1U2MlFMbU5sMEdtRFFFUTFXaUR1cWpjN0lM?=
 =?utf-8?B?eS9Zd2kvQkhJUGkra0RMZWJqN3dKbkhRdmI4amx3d0pvQWxyNHhIT0lzd0lP?=
 =?utf-8?B?N21wMDRaVkh1L3k2bi91TmFoeTJQQkhKTCtpa1Ixb1FjVDJTdzdMNnJQMWgx?=
 =?utf-8?B?M05Sc253czN6cjBRcFdvMzFNNzFENjFob0RIdHpGOERPbWxpMFRIVVBJZ0Fi?=
 =?utf-8?B?TndIeUo4SjdWTS82OVZNNzFMQzM3dUhSYnZvemlGaVJTTHpVd3pNbEthMXVt?=
 =?utf-8?B?aUpkNkZrZEx0Y3hhTXZidVI5TGdid1dkTUFPd0FsRFRJWGpHRjh6L1FYZGd0?=
 =?utf-8?B?YVRtZE81OUdZeUhJcUNpKzdMZmJFWGY1Q0gwOUVkRkg4YXgzd1dHRXpRaXNZ?=
 =?utf-8?B?VjY4QWV3bkxSMzBXVENoRi9Ea2M1bDlHUzFHeE1WclM1NTBYQ3Nvd014MW9k?=
 =?utf-8?B?bWFNL0p3QnpYb3FhRm04YU9VM0VSNmpLdTN5V0xRZHV4QUUxTENqZFdncllv?=
 =?utf-8?B?M0w2cm1sd2puN0RPYTBETzlZWUQ0T3RPTVptWlRDb3UzVVhnZXovUE03aDBQ?=
 =?utf-8?B?MUVZcWtqYVlCY01Ga2x4YXVSZGIrdGd0RW1NY3FnMjZ4MmJXN0ZWRWYzejdY?=
 =?utf-8?B?STQ1K2NtdGIveXB4dUd6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkU3cTFISDhoRSt3TzBqZkNENElPY3ZSK1oxWHRoK1Nsc1kzTm5JSys5ODl6?=
 =?utf-8?B?TXRkajU5VmJOMzVuZGs4Y08rbnl6THJnQlVMRzI2d21KaW5JVWFJWkRCMTRR?=
 =?utf-8?B?cGJrZE5WallsblVKUU1VMkN6enR2dm5vQmk2YXozMityVlR0aFlDci9TV1Mv?=
 =?utf-8?B?bWQzNk5IZ1NBa1JnbVdDd3h0WWFZVGY4eTZBb2NvQ1RjTlRUeXdQVzZvWGJL?=
 =?utf-8?B?WnNsTld0T0lBcVg2UUhlZVRscnk3TG9ta1RMcjJ6Um0zNDF0U3Vtc29nSERM?=
 =?utf-8?B?VHE2YjdHQWhSL2lsNEZ1Q1hkclVMd0R1bnd5VTNoSWhUcHhta09YQU9qbzhq?=
 =?utf-8?B?VXZFTm5tNlcvUjMyN3dPVUxrY3EwL0J1VnFKTVFPcWltdWZRblFHT0JzcVRm?=
 =?utf-8?B?d0xJaWgva3FnU1Yva0REVTdZNWZBeHJtaUJOVGJ4L3UxRy9kNi9WWGZFYXkr?=
 =?utf-8?B?L3l2WmUvWXJROFBHbCtzTWp1UW9vK3A5bmxraXB5T0pVQ1VDaGszM0kxQmhq?=
 =?utf-8?B?ZHhlT3Mzc09hRURjOEpSUXI2MWRaemtQeEtvMkVrcG54WDdsUmszVytuOHlp?=
 =?utf-8?B?Ulk4bU4vUEtqME5XNVlkN0N6aWpUR2piSDJZK1BDdVZGbElZcE85cG9wbUEv?=
 =?utf-8?B?Ni95cCtXVkZidlpFcU1sTUgzR2diaEpNd3ZYaGkrSnVGRDRVTjRnc1F6VkYx?=
 =?utf-8?B?Rm0vNnFSd1ZLYmtxcG80SEJlUkFNUFRyQVRRNEdGSVZ5c0NiTmZWbHQzWjkw?=
 =?utf-8?B?NFV5M05XWnQva1d4NWEydC9FcWowRCt0ZnU1azRvQ0dEeXA3bmxHcWYrVkoz?=
 =?utf-8?B?V2h5OGh6Z3YvVmdDWVhob3lRaDVrQWNrQXdtMlllZmVicnQxTGFQOUswUHBv?=
 =?utf-8?B?cElITjMxMXFwNGxKTGR1WTdiaGl3aG5KSG9TTG1YM0pzM3NOeGRWUEFkVFFW?=
 =?utf-8?B?eHduajdaTWlHTkFQN0xMcUpjdmVTVEJaUEJFQlZVUlZSU3QyOC9tanBwOUd4?=
 =?utf-8?B?NkFRclBrNVFyMG4rOEt3K2ZidGtuSm1KWVRnTTNwQXAzMS9wVCs2UHk4ajJZ?=
 =?utf-8?B?L0hqTFpXNXUvdDhhSFhQWUVOVFlhb1RQdlRqYTdsbG90cStTQnZtYWtjWTR1?=
 =?utf-8?B?MjFZNFl1eGdtVHNldkF2R0NGdXRYMEo0TkZOZVVTMTFIeGUzU09MY1h2bHQy?=
 =?utf-8?B?dC9EM3NyaWdNSnArckZkNVNnc0pRS0NUcEVxdDkwUVVxd2N5MDNZNzQrRHlp?=
 =?utf-8?B?VkNOZTdlOWNZalZUM0d3T0tISThUanpmeE4vd2xueXExWlJLRnR3c0JLRVln?=
 =?utf-8?B?ZGJVcm1kRVRCZVllNWxLNVJWTkZYckZsdnZWN3RRRnRzcEExNTBGUFpUNkpr?=
 =?utf-8?B?UERMaVMvdTJnTHhaQURmVGd5bzZRWjE4eW1abjRKc2M3TXQxNHFMOHpSa082?=
 =?utf-8?B?UlhOay93VmpBZUVlRWovZTk3bURHOFVPc2pLZS9SRkVUSWpBcmRsYmN6UDNK?=
 =?utf-8?B?S3d5dUNsQjJuVGw5MmdmMjBKMHErYlZmOXlYelgwdzhTTGErajF3TUhrQUVG?=
 =?utf-8?B?REFiam1XKy84MWF4YThrc2Q0MTJwN0Y1d1g2cTdPU3ZxQ0FTZTBLSnVMU3cz?=
 =?utf-8?B?K2JQRjhoNU8yall6c1VkbzRNNEI0cmJUdzBkVW1NcUIvakk4T2Z2MDVzUVgr?=
 =?utf-8?B?bHQxaU0vdFpock9jbFZ0RGFzcjBlbE90SzE4SUM3MTV4eTZ0bER2Rnp5MWJv?=
 =?utf-8?B?MnhmSTRubkw3T2JENVc4bEovTENlV1FRYUdCZzVPdy9vNkJPaENtMXV0Rjgv?=
 =?utf-8?B?UkU3UThDb2d4dXk0Y3VUcjRHbGo5UlZDQzIxWG1sWHMySGIrWEl4TWlnUnIz?=
 =?utf-8?B?L2FWczBTKzFZa0JlcW9ua0F6MFhUUDhOWk1pTXJzYkYyeTJmQTJsdDh1YmNM?=
 =?utf-8?B?WkhFczhVbVBsc2UrVWNqSGQ0bUF5K1JSQkpWRG9mT2gwbFJJVG5lNzBZR0VL?=
 =?utf-8?B?aXF0dzBXUEJSNW9pVzJuY2gwNEVmK3c2dFFkTlo1MUsyUUU0OWFZMzA3dE5s?=
 =?utf-8?B?czV1R25OUjl2WUF4K1h2YksySi8zNHI3RU5Lem9rYlZTbzBIODB1TFQ3TUg4?=
 =?utf-8?Q?Sl9OeSdb1dExRKrKf5UBGupVZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852732fd-a876-4eac-fe2a-08dd14f00069
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 05:45:19.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nq3zUrg2W7K37uEu79hR6QT3eiIEl9w92zjNPFtPicgZBUQdR0seD1Mi+6k7MvfuGGFESb6/LFAzvoAJP8PRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337



On 12/4/2024 10:14 AM, Raghavendra K T wrote:
> 
> 
>>>>
>>>> (*) in general fixes are better than reverts, but depends on the 
>>>> timing in
>>>>      the release cycle the revert may be the only option.
>>>
>>> I don't think that the timing is so tight that we should not work on
>>> proper fix firstly.  I'm trying to work with the reporter on this.
>>
>> I agree on this, please do.
>>
>>> BTW, the commit b4afe4183ec7 ("resource: fix region_intersects() vs
>>> add_memory_driver_managed()") fixed a security related bug.  The bug
>>> weakened the protection to prevent users read/write system memory via
>>> /dev/mem.  So, IMO, we need to be more careful about this.
>>
>> My point was that the regression is obvious and it needs to be fixed.
>> That's all. Revert is a last resort in this sense.
>>
> 
> I agree in general to both of your comment. (i.e. since this bisected
> commit had security fix, we shall try to get better fix than a close to
> revert).
> 
>   I am trying to work on this, but it is a bit slow on my side.
> 

I will try to get a fix that retains old bugfix and works well for me too.
Since it is reproduced only on this shared system, I will get hold of
this system next week, and work towards a fix.

Thanks and Regards
- Raghu


