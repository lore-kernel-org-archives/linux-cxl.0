Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB3235C04
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034348; cv=fail; b=oaAHH3mc9Spnz2hlU4+oOTXxOjRw3nupcpYyIo3BW7LfRi4gcjVPHnvRDcSU4OR9odf9URHk/0CE0S7/NvBul3wy4bNCIplYB7GwGaUI+vduuwkGYFQIRCLynnA6qqhNQPtWMuO8Y0Kmx+TV7+0fkWdNd5/keObuOxoLsiChwA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034348; c=relaxed/simple;
	bh=J0+NlQL9/PFe1rQ0avzeaC1QvO3PgTD0ctKN5gNsT/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qrvKMtw4SmDwHuPse2XH1OFkmsr40KC0FmRBZaB+8781DcvAUdGMAaKpfcDjO8wibBpKKdApNv2VDC6/hT3OKwSpb4ncZoiN6mhN1mEhDdA+jq0ySvWCh6OzJ0KFVTrgPTEeqYY1ZNJmcoqt9VakWvlen0tArK4QPNbEgwrMWtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hwB7O5i1; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hwB7O5i1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0REnlAhv2J81+8elo3MkmGYuvkUz0MVcZihH5ameDcIuuQYHG03/hOv6dTJjyK1fExhrnywu6pZ/+e/GMcaqnySsxvxZ9e3UrvV0xkkbD68j7sZaxtR55l3GqDl1ZfIIAbYj50Pok/n/ZB0JxxVdcq6ucoCV9kR8de5wmctqSuzflHqXDg3cS5eNoR+d8DiBQDjSHujK95wRxKm4mQwgHl7oWG6jTCYNoSXywp32XbNRmv3pgqKZPgAi4fgveDiu566L/TnC2bfSEsbKFTgM+T6o6VUvsXDxgKkkOiWmknfb29xLN2z21KHqeJ3IjFj3pCfOGaM652klvTV+LklSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQoHxFZoqYylTGBATHhuvUnEYw9R8J9b9AEEb4dLI/8=;
 b=Ay40msEIMeNneF/hGRAf0v1AFyte7R0LPh26+3WB97dxO+NPCXYT9BgEDGqzEW7ofhTWp746HPGH4cnj9hdlb04Q50V5x1dExZTkVs/LOX2j1Nzu3xkQMaNNEI74tFuWW+zX85OjgA6lloyy/05eP1LTp60zTyJckVr8iEIkkuDb8sG4r6+P3UHYBnP9eJxuLfSXuAgd6StAUmDSJt/UmszlHDZ0efxU1UhMXZ+D6qMBqCvNoBp3kbUy4+0PX6+rGneLbivY996zvkbsOx8SvPjAnOYAaYiD/LeibTuZY73rYM+OFO1myJT4/Q7m2a9E9Fjf0Vyb/cD1zQGqoyaqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQoHxFZoqYylTGBATHhuvUnEYw9R8J9b9AEEb4dLI/8=;
 b=hwB7O5i1sy4lOlrihVII5Va0zW2jw6vEGcliouy4UR/+JEih4TwCWyTFgVoq4OTe9Pva+lS6/0/PaYoG0RAX/at4zKtEL3oNik6B7Je+sx0lAPcX3e1nph0nrtw5Bi6pllZ70FzWHGWBJFEBczhg+FER8QE624MwEYbnRvp399c=
Received: from BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 20:39:02 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::b9) by BLAP220CA0021.outlook.office365.com
 (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 20:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:39:02 +0000
Received: from [10.236.179.218] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 14:39:01 -0600
Message-ID: <289fc275-43b6-424c-8c0c-28c5d527ac35@amd.com>
Date: Mon, 3 Mar 2025 14:38:49 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] type2 cxl initialization
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c1149c-5bd9-4e28-780f-08dd5a936efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnpCMWFIcW5oVjU3ekd2czdWL0hSZGtackVkbS83MDdWUWdtOEdwcXhaV3Fl?=
 =?utf-8?B?TWNzTitUMWhES0IxaHgwemFwcnJFSUpBQkIzVlM5eXZaYlBYUXFYMHJISDNz?=
 =?utf-8?B?UWtZampCTkM0NmIxNGw1SjcrSWRaaGNaRXpwa1I3RHFCaDU5UnFZSVBKM05V?=
 =?utf-8?B?R051di9QaVVBdk5vZ3c5VFI1dmZwU0J2cTV6azhVN1JkT3JLTjBUL1cxaUxB?=
 =?utf-8?B?RzN3QTV0V0cvZVEvNnBrY0xzQWpLbmljSGdzc0hMYXRqSE1QNkJCcHhJMGNQ?=
 =?utf-8?B?MmpYeE5Xa1dQbW1raG96MVBDV1Z0aTlERDdVMmp0endlbjRzOWV1Z3JFYy9y?=
 =?utf-8?B?V1NRNHpwVDNvd1lJSXI2UXJ3NkxzQkhzTDVoV1dqRSs5RUF3UDJYNDVabG1Y?=
 =?utf-8?B?VmNnSXg2NGNCYm1WMmt4d1RpOGw1UTFTZ1dWSkpkaERvcG9BeGdZek4wZFNE?=
 =?utf-8?B?RGQwN1gyNHN6TTg1MURyQkI3MzYzT0ZLVEpGR0t5Y3dkbllIVlFXVU8wVEJj?=
 =?utf-8?B?UG9kREo4eGFDZVVVVW5Ob3VwbFZJMmpoaCtZTHlwMlF6Qm43bmJndVB3VkIr?=
 =?utf-8?B?aTZUUGdaWFFCOWFmTkFxMDBaZ2FEc1hiUkxzcmhrSkpQNHBjaE1IMjVXQ1Nn?=
 =?utf-8?B?MUZWL25JZE1HYmtFei9NbnlvTkJTb01iOTd3azVYZXdzdEtyTzkyTTYydkEw?=
 =?utf-8?B?RnZ6eEY3TGx3ZWZLMkxtQmJBK1VYcEQ2WFZOcm10RG5Oa21aNCtFdGpmRjdZ?=
 =?utf-8?B?cTViM2U5SUFPWXhYMmcyUEwwL2hjWlBZamlBeXRVRWw2RHNqRjRzeEI2WU9m?=
 =?utf-8?B?cjNwSGovT2VHcERWMDdjdXBUWFppYWNDSklUZXM0RFIyQlF6YU1tOWFzR3A5?=
 =?utf-8?B?MVlRTVNYa25UbmMwOFZ6RmpVaEp3UGp0aWNBNDFGYjZUeVdmNXVzS3ljcDU4?=
 =?utf-8?B?MDBFdjc4b3AxMXhSQjFWa0VGbGo4RjBMQ29mV2RSaVdGcmJyc2pYeEhmaVN4?=
 =?utf-8?B?UDlXR21pWWZ3dmFwNEJMbUVoNTY3YVdxN0E0Z01UWTR5NEs3MWQwbzBzdFY2?=
 =?utf-8?B?TE5xK0VXcHJ0Qy96TDczWS9XR1Zwd1BpMzFqTVVRWW5BTXhTWGpONENzVWYz?=
 =?utf-8?B?SHFKaitXM0FYL0hsYy9FN2VZekxZQ0NIM1VTcnRmbWROV2lJZHh1bVhmSGtl?=
 =?utf-8?B?TXJ0ZFpPOTQ1UnpUckNsMDNOOWg3bEVlS3hoVTlKRzd3MTFoZUg2OWUweGtp?=
 =?utf-8?B?VmlEek5VcDM3d056RmV2MXR3YXhSY2RWZEhkZ2VPQ2JoMlkyZTBnT2UrNUF2?=
 =?utf-8?B?OW9yVkhtNlExMnNuS3czamFzWXBoSGZRa0FSVXI1cXRCR0VLQjdTemdBZzkz?=
 =?utf-8?B?VUNWRXZoWjZNM1VqamhFY2FrZmFVVTRWbVIvTW92ZThURnFFbXlteTB6TWpp?=
 =?utf-8?B?TThFbWtpUWpHRnNhUHoyZEVxUm4wY0h2czhsN3RmMFEzTkdGYkU0YiswU0t5?=
 =?utf-8?B?czlaL3R0SVZSZzVqMzJZcERNdkwwRWN5RE1MbTg5M1AyU05qS2k4UllZNXVa?=
 =?utf-8?B?TFg0WWh4Q2E0cmczSHlydGtoK01kNlJyQ245VE91emxUem9TRDZ0aGZVSmg5?=
 =?utf-8?B?VXROYW1VdnlFRWpKbm9lWkpTbFB2VkhTREZJdWNNRUlGSzRvcTh6cWQ5WWZC?=
 =?utf-8?B?RWJUYnJGL0Y2Zll2TVQxcE5BOFhwMjRWQmpjK2lRVVJqWWc2eHB5T0pqV2li?=
 =?utf-8?B?Ni9QRCtodGRkTWdmckNKYUd0OFBPblJhaC9taDNTbnpYR3FzOVpUNXFrOFd1?=
 =?utf-8?B?WnRKNngreGVwYVZleDl3SWdWMVpTQWZiUkgzTWtlNGhPbFdvZ0tkSFdMdDBK?=
 =?utf-8?B?RTBQNklBTXY2cW52ZnJmUW5IOVc0dkhBbStqQ3NQTms3a0pqNjVJSXM0WE9C?=
 =?utf-8?B?Y1d5OGZIYTZ6M1g0Q1RHL2dlTlRrblpKZkhuOE5ydkxuMkVJZjJCR3pCbUV6?=
 =?utf-8?Q?2xpF2rwmg5f/TfygBkYTBSqAKAR/Zk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:39:02.4807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c1149c-5bd9-4e28-780f-08dd5a936efd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

On 2/20/25 2:00 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Avoiding to send the full type2 support patchset until there is an
> agreement about how to do the cxl initialization from accel drivers.
> 
> Using the idea from fwctl for embedding cxl_dev_state in a private
> accel driver struct and a macro helping for the allocation and
> initialization of such struct.
> 
> The main problem is the amount of internal cxl structs which need to be
> public for accel drivers which we tried to avoid since v1 of the type2
> patchset history.

I have a suggestion or two in the next patch, but in my opinion the only
potentially problematic exports are the cxl register structs. I'm assuming
allowing accelerator drivers access to those may cause stale values in the
CXL driver, but I haven't looked. The only suggestion I have there is to
use pointers to the struct instead, but I imagine achieving could be a
non-trivial amount of effort.

The only other member that may be a problem is the DPA partition info,
but I don't know enough about that to comment.

> 
> Alejandro Lucero (2):
>   cxl: add type2 device basic support
>   sfc: add cxl support
> 
>  drivers/cxl/core/mbox.c               |   3 +-
>  drivers/cxl/core/memdev.c             |  25 +++
>  drivers/cxl/core/pci.c                |   1 +
>  drivers/cxl/core/regs.c               |   1 +
>  drivers/cxl/cxl.h                     |  98 +----------
>  drivers/cxl/cxlmem.h                  | 108 +------------
>  drivers/cxl/cxlpci.h                  |  21 ---
>  drivers/cxl/pci.c                     |  17 +-
>  drivers/net/ethernet/sfc/Kconfig      |   6 +
>  drivers/net/ethernet/sfc/Makefile     |   1 +
>  drivers/net/ethernet/sfc/efx.c        |  15 +-
>  drivers/net/ethernet/sfc/efx_cxl.c    |  53 ++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++++
>  drivers/net/ethernet/sfc/net_driver.h |  10 ++
>  include/cxl/cxl.h                     | 225 ++++++++++++++++++++++++++
>  include/cxl/pci.h                     |  23 +++
>  16 files changed, 417 insertions(+), 230 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: d5d2106e2118c4e09fef131d9889f79559b95bfc

