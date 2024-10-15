Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F55231C88
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953148; cv=fail; b=UgbYhzeWzBhkiHUb6beNJnsb2E71vuVRAa+zGe7RQj9RUnJa6O1r3d/S/aE/mS5MD+Ok5TPY0TtxKLQmWqJxbSWB1P7aPERDQGFLKnWkH7ITqoMsBbbV4EVODxf1fFMM+CMxwe/ilKyvjqk9y2m48AFBfjOZRX1+sHy1mb88nAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953148; c=relaxed/simple;
	bh=CzMQUxK5IvoBYO/YKZyI38KvohJmztJ/FM0Klek6GFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PNhIJcsJr4ARXa9NyVP30xA2Jkyt1lwiysaTUhPYzD9t7KgOi8H7Z2h40gbPIZg69DC07anbKS+2khAkbKUx2ohba0o4I1mNv4KuxiNc8Qsf9TG+j+A8BhsHbIT88oqp5QgEOzVtVD0HSuz0ZIGdTRjIzq2FOOcwwakzBTDt7go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AIhBCLGt; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AIhBCLGt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1728953146; x=1760489146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CzMQUxK5IvoBYO/YKZyI38KvohJmztJ/FM0Klek6GFc=;
  b=AIhBCLGtuJxdBgfZhO9LMY7BLjviSLaWg0jp58quYIawcW/y9/rxjX7s
   naOvUaU4d+qfkX+XrTzXaW8X7rzojKWEuhERumRmQejC3zh2bRTSkEyny
   ijkn3ipXCZKVa9KQNx3xuGIgjEohS+y+tqKcxNMhDIYjwknOIOlXeFWLA
   BRqLOs3Zx4AOM5my6R1HlEa9+GPPEa6NvZjfMApsor7Rsy/Y124EgFIg0
   pSWzmwdhyF2phnmqwbctaJXf4M8WBDkoSSk4DmnrFgCjhqRfUBQ0NWr3h
   FjwpOj4fqQ21e3EWuNRrgENl/1uBPXEEjeYyhf+39v++yK53vQ3WUinkf
   Q==;
X-CSE-ConnectionGUID: gNHeUqX6R6q7waFeWqB5KA==
X-CSE-MsgGUID: CnQSdUbLT+evHRL49g+LcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="44659281"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; 
   d="scan'208";a="44659281"
Received: from mail-japanwestazlp17011027.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 09:44:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AP5p2dNISLRcUvVHXRT+x9b8kDNfaUn8uIO0OlXDVUEwF7v7UcIpLeuYBSsxuI/orxCmcKMZRv5BN9Zq8uiLSv3QuSglHa+A6cRHxLMfRAOTgN26rNBwtNKbz6jMZlivzZy9g66+6Wfw+AEu/4jeUIrLoWmztawl5WFhbaE8ESuDRJg4sN186Kjo4mp4Wd8JzPpRRm8RuDYFYhUjT7ZYaDxP658ztoItETSDZXTegIyNOiEkEK9sdzPc2fousHAWgJit9diTNJDrtoT4HDQN+DfVbIajLUoygHhqu0I4PtZytuEkaq+q9Rwkmqbupwds6YuOl+ObWty79L30+RuW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qc2aSBvVLBJwV5M7WINxh/WGTY81zNCAArQNtcG+Fc=;
 b=hbIp4Q8DVLXMdttRtiK29SwHkFUVg/AdXAq94VyCyRAB+Q5anvlAZPrLXmOn5AnopDnivn7dXBOacr/keOh2ktAu+2mdAEmg9TwNdzD7c91vsDnG8rRpqN/LXTpWkrx2EME+6toZHLUsKqsdcZLOe0U8rlKU/PFhaIV+TMFew03T0Oxdy1f2t4sXZcTQmZcCQMAkpshkhEh+Dofn8Mjd1bboavNRoXAn8Y1MqHJPtwb3Xrl4VRFpB5skP6EiVLAiTS6/B72FP0t3gKz/xH8CLb/b7tVc4p1Kx111XXF3eWSBudvcmaHA4TDgweU1wzD1RHruWOaWC6aWM5Nmu0ggqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYAPR01MB5660.jpnprd01.prod.outlook.com (2603:1096:404:8059::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 00:44:30 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 00:44:30 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "mj@ucw.cz" <mj@ucw.cz>
Subject: RE: [PATCH v18 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v18 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHbFGhJP5jy01iKLUmvVxGTyGzkELKHDOLw
Date: Tue, 15 Oct 2024 00:44:30 +0000
Message-ID:
 <OSAPR01MB71821938AD4F9E3486DABA08BA452@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=0a1f3506-0c28-4add-bd20-4c7d2ae1fc88;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-10-15T00:40:43Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYAPR01MB5660:EE_
x-ms-office365-filtering-correlation-id: 2994d414-ddcb-4673-2ad4-08dcecb28796
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?RFluYkZtVDBjdW1FY1lUZmJpSEVlQXVFK1pOS2dEekRORFBlN2FEd1FT?=
 =?iso-2022-jp?B?QzQwSmd0d0g4MFZSYktZaDg4Q05VYnh0QWQ4TWFGb1lJeTJYeEJsemF5?=
 =?iso-2022-jp?B?R2VTaXUrZHFkYS8zWGU5eXpFSlFSL3ltN1pvaDY2RExycStHMnhDMmhE?=
 =?iso-2022-jp?B?S0NUMElEdm90WXdQWEdNR0VNSG5ZbS8xaUxzcXVrNTZtWW5rUjhCbXBN?=
 =?iso-2022-jp?B?T0dQTG0yNXY5eTQxRXpTZGVFcENtd0dFL212VmZCbllQNmx3RFpvK1U3?=
 =?iso-2022-jp?B?R3RpVnlVdHVnS25tekJDQXNjN0lyTkgyMkhuVEZhckJZSWVralQ4dWsx?=
 =?iso-2022-jp?B?d1hqWDRVUHcvaHh6dDdtV1NXNWRoWHB5TlUrYi9wVCtzWWMvTVU4NHZp?=
 =?iso-2022-jp?B?ck1DTXNxQ1BnT3JXSUd1dEp4Y1FYNXVibWQ2QjczTzZGMmhSdmRqb003?=
 =?iso-2022-jp?B?N204dkpiS1pZZnFIQThsMnpjcGxxYlRkdUNLajBMVEZwUjhGUmMvUHkz?=
 =?iso-2022-jp?B?OEVCOW1lS3pEcjVwT1M0dUhMQlBOcFFITTdySFE2Ukx3Q3ZIV2xhZmV3?=
 =?iso-2022-jp?B?Yk1QMzVKRVd1dkhMWE5GZFRRc0YvSG1WNVlySjZYeFFMNFFsWXAzZWE0?=
 =?iso-2022-jp?B?eUxZY1RWUURDUEFubC9DeFM3dWgrazJrTWppcDQ0a3BIakFrc25ydW5E?=
 =?iso-2022-jp?B?S1RWeE5XZGtjTE15VnJvN1I4a2hCdjZIS1lsaUNMN2xmbTl4UW8vUFl3?=
 =?iso-2022-jp?B?SkxVcTBMQk9GRGpuMWw5b3hDZTNtZTlWM0IzTzlVY0JpSW1xRmFHM3hW?=
 =?iso-2022-jp?B?SkJlWmZYRHozOHQwbXZ4QjdOS1o4YlZ2ZUVtdFJDUEJmeE9ucFFTWWhi?=
 =?iso-2022-jp?B?WXNhR0RtaHRKemU2Y0FpejBGOXlFMGZLczBib2xBYU9DWGJZOEhJRUN6?=
 =?iso-2022-jp?B?cUEzNWxBN0RxMFkzRGdCYjA3TUlVRlg5ei9iZDVoQlhMV0dxT3RNNlBp?=
 =?iso-2022-jp?B?aXY2MVFuTEhzT0ZpcTNFZ3Zvak1SenEyQ21ibDJjN0RJSkxObEpQNHha?=
 =?iso-2022-jp?B?T0Vob1U2WmV5UGEyT2RIYnZJWVFiM3plV3lFR1l2N3IwKzQxNUZsZ0xw?=
 =?iso-2022-jp?B?clFSTFpVOFZ4ck52dVptUDBZUEkvYmRDZHpPdUg3b3cxdU1UNy8rZlhx?=
 =?iso-2022-jp?B?QkRNaFU4UTNpVW5kQmE0a083K3UwazJwMTMwZ3pEMHhESVE3N0dpdlJo?=
 =?iso-2022-jp?B?cVZ3anVkTUVFSnRBbGcyMENHcmNhZkZJaUszRkVxN01hWmJGRHQ1b2lm?=
 =?iso-2022-jp?B?TTJ2UmRVOFZISjlzdHo3aUxoY1NlYUlqTXRhTkg2ZkNiZ1l1KzVUb3ZS?=
 =?iso-2022-jp?B?MXd5TzFmQlRMak84NmxXemp6YTVCSEtsUFZMazRlVkxpYTI3eWdhRktH?=
 =?iso-2022-jp?B?a1pUNnI2MHdrTHhyVXdLb01idmVyOTNpY0hEVHpPSE1xOVV4R0pjOTI2?=
 =?iso-2022-jp?B?aDZEZ3I3WWkvM0RSaGtNckdLQmVvdWlWY3Z4MFRua202Qjc2dDBZaVNS?=
 =?iso-2022-jp?B?SG1CWXBLZzRyQjlYK2F2cDVVc3N3N1hySVBXaGNyMGhNd09SOVB2WjZC?=
 =?iso-2022-jp?B?M2htNzZBZFZBN25pK2VpMWtHME10b3Jrb0I5Qlc3VC9VbTAvWW93RWZK?=
 =?iso-2022-jp?B?WGhaWmFrT3dDZExISmtteHNmSWtsR1JvUFJFV3BXS3VnTlg5eDg0cTNq?=
 =?iso-2022-jp?B?RHVoREx2ZkJMYVk5QUJXeWkySm5mdTErZGF5bms1U2ZUeERLMjE1Y0s0?=
 =?iso-2022-jp?B?cVYzOUJWRFVjdGFtd0NTdnVxYWN4b3hsNy94N2UyUlgwMnNVNWl3eVdv?=
 =?iso-2022-jp?B?cnlvSkw0L1liWHl2S0tDOE4zOE1WdENxOER3cXY0OUhRWEQ1VjNWZUlM?=
 =?iso-2022-jp?B?ZmJxQVZTY0lLRThLcEJCdnFaazQ3a3Y4UXNKNDBFdGVrNS96U2hhVnp6?=
 =?iso-2022-jp?B?Zz0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MjVlaHNyelRXaDZxbnhKcWY0Y3R4YUtWZDAydm9lUDFOb3JMbnNtSWpV?=
 =?iso-2022-jp?B?UThrQ0JOWlE3eGNVWlAxTWlSWVUzOU9YeC9senBoN0RVekhxQUphWjhQ?=
 =?iso-2022-jp?B?OTdhb2lxYk1GL2dZZnplK0hScldvWHZsT1NxWlZ4NEtsOTk4WUJKREVR?=
 =?iso-2022-jp?B?dlBzMHNKRmpWTlUwYnJ0N1dWTXd5Qm84L1dUc0xvM0dYT1hyKzZUVitv?=
 =?iso-2022-jp?B?dDlRWUZKNGxObGpXejVLU3djbVB3MEQ1V1B4TmxibXpXYWJ4MmtQUTBs?=
 =?iso-2022-jp?B?blhDd2RjS0Y3RGNlWDlRbEMzMTVDRjVtUGdUZ0l4Z3FsVGlZU056ZlZx?=
 =?iso-2022-jp?B?Z1lYR2RCWklpK0ludzRwWjYrYjJMRVFyMU1UNDdmbUFuNENXbXcwd3JX?=
 =?iso-2022-jp?B?N3NGaVpDMzJDL1R3WGtIWFBmNU4zOVpVQWI1OUJVTmFxTzZOV3gyZkp6?=
 =?iso-2022-jp?B?RnhtK1JMYlFxN094cC95L1VLV0VwMDlrMVlFYmNKemI3ZTVHZGwxakFm?=
 =?iso-2022-jp?B?UlBOS2Z3UG1Ea3cxTnpqc0JYdTdwRGVBV1dXU3lick4veGczRHZpNnhi?=
 =?iso-2022-jp?B?UE1BT0RqM1cya3ZWWmFNQWlKRDM1elRwUk9KYnVuUndpNFR2My9mTnNG?=
 =?iso-2022-jp?B?VzRYaE8xY2J4cFpaeEpFd1pVVThuK3dSdS90Nm5MbTl1emVXbHFUMUZN?=
 =?iso-2022-jp?B?c1JrYjc3Y3JxbG42dzBkZG1McVl6QUJwY3pZR0JPZlphSjBSSGxkSlZI?=
 =?iso-2022-jp?B?eTErNGp5K2ExQ2hZbkxuUUpDQU0xa3ppRnRZNEthVWNjQXFHZjdoTGU0?=
 =?iso-2022-jp?B?L3Y1Tnp6TUM5VDFhMDNSaURZazkzVlNhd0NtcC92S0xuWklxMVpqTTVV?=
 =?iso-2022-jp?B?Y0Y4TTRQOE1LNlJRTmI1a2xyZld3UDRXRHc2NUJzcEZOVjBlK3k0dGkw?=
 =?iso-2022-jp?B?YmJzSkhiTGk5Yk1MMVZ1VkJHVS95WGkrWUtGaUtvNm42TStqZ1V1TXNG?=
 =?iso-2022-jp?B?V1JRMmdORmt1VGVBZFhJb0dqTklic0NJVjRhZEcxTDQyZ0lCMmdURllG?=
 =?iso-2022-jp?B?RDgvSlE4Z3k2QUIyUjZkQ0h1R0xIalJoUWxEZzJpM3BhTWRlTkZFOHYr?=
 =?iso-2022-jp?B?ZnBXTU8rZjNSTy9VbVNzK2RpUjhhaHRSQmk5Y0pxRFJEM29UckFRbVZO?=
 =?iso-2022-jp?B?VThpdXRhS0hXT3Mrdk1HdXdaUUlOWWx2R0JlT21waUIzV2dOWWMyTWh0?=
 =?iso-2022-jp?B?SWhyUHcvNkdhUk5idktQVWFOMk91UFRjaTRmY1ZlWnJpd0REb3R6RVA5?=
 =?iso-2022-jp?B?VVBlSkR4SW1vMHhZNktXRkhWeHRHZGI4bnZBaWNRNVZ0dWxNR2I4UFll?=
 =?iso-2022-jp?B?bVIyT01jck0zL0JkRXU2ekprOGJISjRtSlBpUllsNiszcURidFUwMlNU?=
 =?iso-2022-jp?B?clhFOUM4dXZWOVVEMHBjbDcwcU5Zb3lyRDhKNlNLUXJmR0ZIeldoNExi?=
 =?iso-2022-jp?B?dXlLb0hjUkhaV0xFRFhvOUNCa1Q3cS9tV0hkRWRSQTZPMDhrTFJUZ1E4?=
 =?iso-2022-jp?B?UFdhRk4vemdQckxmaE9rTC84UlkwTlFVRXhJakZ0WEVUZWQ0NU1qMVpj?=
 =?iso-2022-jp?B?RlBzQWRJY3dxWWtycmgzZFFMMFVDSjdNY3JzRVhsVERSaFlIVW1JNENh?=
 =?iso-2022-jp?B?dWJVL05CU0huV3N0Q1V2Y1M3aGlHMkI2anFYcVlvYjJtbUVpdWRCNERl?=
 =?iso-2022-jp?B?Y1J1YndJcm9qcXlta2V2emp3QWQ3UUNaQWx0ZzdXTVpKeDJ3VG80ekM4?=
 =?iso-2022-jp?B?S0Zpdkg3bkE5eHM0dWVvSkszbUxMbjgyMHdoNTUrbVVVMktBbVBCYUhH?=
 =?iso-2022-jp?B?VGcrcWNLQU44WjhlSlpjMEdYMnhtazhIbkZjdTh0L1pwQ0U1QUR3Rzc1?=
 =?iso-2022-jp?B?NU9XejZXRnROTXpPOXN4ekVvVERnRFdTVGdKc21pWmdPVThseHVyVnRU?=
 =?iso-2022-jp?B?TlVFYU5VZGtJN0RGNStwcVNrQzJnZkhqeW1kYXR3L0VyQUdDemU2U1o5?=
 =?iso-2022-jp?B?aE1IVlNzT3F3TVdJcmFNQnVIWS85T0RWSHlRNHZDdEtZbk1TRURFMU1l?=
 =?iso-2022-jp?B?S0xqQlZRU25GbThxRjREUWFvcUpBOHdiRmMzMzRHdlRja2dHVUI1bzdV?=
 =?iso-2022-jp?B?VFgvS3V0eUtqdm1wUHljMFlNYW5od3hrUFBKSktTc0xiUVg3dlpnOXJL?=
 =?iso-2022-jp?B?Q2gyTk5YQ2wxMVFpSkkxZUIyYWVIZWNLdXVQdGRSdm5uOVhkUUpic0la?=
 =?iso-2022-jp?B?ZnFEMktPcEpGZUFoZnczaGIzaStSa3dlV1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GlBq7LAiVr2d5LuKRESTOkUnOMP6YRSj4HsxWeK1o9IfdKiWu055hjQEx6St1vodBMbxCi/kqtXybQ6fO26S1hySHxG+dZgnaxe6ie3ZfrI2P1CNoPKyHQJ0c+5XrZIjGdCVHiSlsXFCnxVfpAt/OcHr5h6HsBq7/vhypIB+V2M7LhHbag0UYPT7QsKIeNWaFPU0XsDLjTyTtaPLrXqTNPNuGsaeXvVL2WkoV8bXVNHCh+SfxztSuh1sxrKmdhM5uOQ3Kf2TC7acy+y3m95J10TxgGWxunluXrB+oVj8tK0RbNFMkbl2rSLCZswemY1yBQLJdc1mg76oexBEtFOLSxKlRBIsC5fq/XTi/J3CqjbnaL9+LUBgaaj/XiSq72N7g75p6w2WZ46eEYvcUcqt9JB8syEbDYa9DylFlpJ5dj3fvszaRKZ+zkORqDNtMN/tVPba80O4RGauVFsGiGNYRUmU2Q+IW8M/2XCbHDCEQQyUZgyKiFcUZVeZMB54sLJMeMDdNgojOCuGg8SKe8it55XIil3tQmEdQ0jxl5Enf9a7NPUt4I42B4mzjIxVbMPDITCkv7j2vhJi+XuSnWm6bK0Wb+WNYBgWXNu8U+xizl/90oXemC0fvZ8W9Oz6w1Ti
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2994d414-ddcb-4673-2ad4-08dcecb28796
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 00:44:30.2479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1QZim8tGdDIGNQxMEo9skj4toB5Pa7zxx1bf4248dOEUr7LV+ok1MCgE2KFKDLjfjmt+ADfbdzRHNzGgCvg22fC99Bv8SQ/3HSifTSpO6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5660


Hi, Dan. Could you please review this patch?
I think I've fixed the issues you mentioned.

Kobayashi, Daisuke wrote:
>=20
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards, the l=
ink
> status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a different
> method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped in the
> configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped to =
the
> memory mapped register region (as per cxl3.0 specification 8.2, Table 8-1=
8).
> Therefore, the current lspci has a problem where it does not display the =
link
> status of the CXL1.1 device.
> Solve these issues with sysfs attributes to export the status registers h=
idden in
> the RCRB.
>=20
> The procedure is as follows:
> First, obtain the RCRB address within the cxl driver, then access the
> configuration space. Next, output the link status information from the
> configuration space to sysfs. Ultimately, the expectation is that this sy=
sfs file
> will be consumed by PCI user tools to utilize link status information.
>=20
> Changes
> v1[1] -> v2:
> - Modified to perform rcrb access within the CXL driver.
> - Added new attributes to the sysfs of the PCI device.
> - Output the link status information to the sysfs of the PCI device.
> - Retrieve information from sysfs as the source when displaying informati=
on in
> lspci.
>=20
> v2[2] -> v3:
> - Fix unnecessary initialization and wrong types (Bjohn).
> - Create a helper function for getting a PCIe capability offset (Bjohn).
> - Move platform-specific implementation to the lib directory in pciutils
> (Martin).
>=20
> v3[3] -> v4:
> - RCRB register values are read once and cached.
> - Added a new attribute to the sysfs of the PCI device.
> - Separate lspci implementation from this patch.
>=20
> v4[4] -> v5:
> - Use macros for bitwise operations
> - Fix RCRB access to use cxl_memdev
>=20
> v5[5] -> v6:
> - Add and use masks for RCRB register values
>=20
> v6[6] -> v7:
> - Fix comments on white space inline
>=20
> v7[7] -> v8:
> - Change the cache value to offset
> - Access memory map area in rcd_*_show() functions
>=20
> v8[8] -> v9:
> - Map the pcie cap in for all the time the driver is bound to the device.
> - Add mapping the pcie cap in cxl_rcd_component_reg_phys().
>=20
> v9[9] -> v10:
> - Change a utility function for getting PCIe capability.
> - Fix tab alignment issue, error handling, and apply suggestions from Jon=
athan.
>=20
> v10[10] -> v11:
> - Add functions to have one function do only one thing.
> - Add a size parameter to utility function arguments and consolidated the=
m into
> one.
>=20
> v11[11] -> v12:
> - Fix the error handling in cxl_pci_setup_regs().
> - Fix and clean up some details.
>=20
> v12[12] -> v13:
> - Fix and clean up some details.
>=20
> v13[13] -> v14:
> - Fix and clean up some details.
>=20
> v14[14] -> v15:
> - Change dport lookup to be done only once.
> - Fix the visibility of cxl_rcrb_to_linkcap().
>=20
> v15[15] -> v16:
> - Fix the port leak bug by introduce a new scope-based-free handler
> - Improve the variable names.
>=20
> v16[16] -> v17:
> - Change used function for making struct cxl_port *port
>=20
> v17[17] -> v18
> - Rebase to the latest code.
>=20
> [1]
> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06
> @fujitsu.com/
> [2]
> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@
> fujitsu.com/
> [3]
> https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@
> fujitsu.com/
> [4]
> https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@
> fujitsu.com/
> [5]
> https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@
> fujitsu.com/
> [6]
> https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@
> fujitsu.com/
> [7]
> https://lore.kernel.org/linux-cxl/20240510073710.98953-1-kobayashi.da-06@
> fujitsu.com/
> [8]
> https://lore.kernel.org/linux-cxl/20240606074814.5633-1-kobayashi.da-06@f
> ujitsu.com/
> [9]
> https://lore.kernel.org/linux-cxl/20240610082222.22772-1-kobayashi.da-06@
> fujitsu.com/
> [10]
> https://lore.kernel.org/linux-cxl/20240611055254.61203-1-kobayashi.da-06@
> fujitsu.com/
> [11]
> https://lore.kernel.org/linux-cxl/20240612075940.92500-1-kobayashi.da-06@
> fujitsu.com/
> [12]
> https://lore.kernel.org/linux-cxl/20240614045611.58658-1-kobayashi.da-06@
> fujitsu.com/
> [13]
> https://lore.kernel.org/linux-cxl/20240617043702.62028-1-kobayashi.da-06@
> fujitsu.com/
> [14]
> https://lore.kernel.org/linux-cxl/20240618042941.96893-1-kobayashi.da-06@
> fujitsu.com/
> [15]
> https://lore.kernel.org/linux-cxl/20240716042540.89639-1-kobayashi.da-06@
> fujitsu.com/
> [16]
> https://lore.kernel.org/linux-cxl/20240815005510.220835-1-kobayashi.da-06
> @fujitsu.com/
> [17]
> https://lore.kernel.org/linux-cxl/20240903025915.270521-1-kobayashi.da-06
> @fujitsu.com/
>=20
>=20
> Kobayashi,Daisuke (2):
>   cxl/core/regs: Add rcd_pcie_cap initialization
>   cxl/pci: Add sysfs attribute for CXL 1.1 device link status
>=20
>  drivers/cxl/core/core.h |   5 ++
>  drivers/cxl/core/regs.c |  56 ++++++++++++++++++++++
>  drivers/cxl/cxl.h       |   9 ++++
>  drivers/cxl/pci.c       | 103
> +++++++++++++++++++++++++++++++++++++---
>  4 files changed, 167 insertions(+), 6 deletions(-)
>=20
> --
> 2.45.0

