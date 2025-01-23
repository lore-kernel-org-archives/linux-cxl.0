Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AD20D50E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626228; cv=fail; b=JitKX8W7GAo1HCoaYg9aGOkXynpKEF2lLLCv+1fkbhuEMFTPwimAHeswJHf2uPbTDn583xxLMH4WAAGXyAz/wG/609RgQK4vqPU8oTDCZovFcrJv4XxYW15A9n2Aul597eM+QCTlqmKXnoUduFrIVDg6fI2cylX6HxgaHh1f7fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626228; c=relaxed/simple;
	bh=nvpGrmUD6divgZHFZ62BUnx2kfMpv3jGdc9+5Uxx08M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ng5rCIFhiNhDkUTpdIqpG11ou/PNEXscBFIqixW/ZXpupuY5Vm3YdrKdbqG3yXZ+B1R53vRGLlU/iDbPYBmBVjiO4jul0K9ntg3W8n/9fBJDuU9oid/DiVdFrHtFB/iyGqVahntw0yd2mN+L5zmIj/GOPHnO5MI/J8vUawTCAPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=yEYJ3G8j; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="yEYJ3G8j"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737626226; x=1769162226;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=nvpGrmUD6divgZHFZ62BUnx2kfMpv3jGdc9+5Uxx08M=;
  b=yEYJ3G8jpyKnfIw0MW9oNEadHhqKBaWAo+79jU0C2rGzil5wpZM/hT4F
   BT4TfW5KcmVVI+mXsRcUHcJ4Dg8gubNXZIoAMBXMAC7sDZf/XQ4w9kbvK
   1guqs5URfNeR3UP+Wgo6RwUph90Y9+ayv6O9Cd1QLWH1Y80XuxQ8an/eM
   ADPH190kSZg92cG2sYY2zXV3RWjAW3g0R/qkmj3s/kSpcA3yiEe6HK4Lx
   b+/OC4CQE18e/TSkpgyMAFyVw+VuJGVKdH9H7Eq8lO3BSFEbb2zI/KLU1
   FccpbwlDFfxBUbTxcWHgLMGQjr7A97F1yYlteDsGwb+vylxY1vYnT88b6
   g==;
X-CSE-ConnectionGUID: K6H6KcsUQjmTIJcU1OPhIw==
X-CSE-MsgGUID: C9X/ex2iTsqO0UbsF3YRBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="144083960"
X-IronPort-AV: E=Sophos;i="6.13,228,1732546800"; 
   d="scan'208";a="144083960"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 18:56:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB3hC8N+TH6GSG+4W/YKqqkA7Z+sJkcaCUgQk3uFl+SMKbC/+xF2GzzATbxUCk1Hn/HCd80oBIa1QjqLuCQLDXLY35CghUpDncw9tX544Rv8lpG+nhSnkwAcsUTwOY21RW503CtWxwWiGuHMCiykTeC8H+H/zQ3hgVYiminfRNdc7jfUUkOC0J8Kt8iD39c0TSXNL0eeVsYmfA6IN1/6uVmB0AhHeNJN8sjeTPa4DEDec81zVGh4qeaRedtRw4pjU0xGQ8XsgJ53kjMqF3wBjwKyScGUw8y7zRZwIlY6HEQqNbDdj9varNkeuLzsof56rq35Xj2T0qjKnNdP5nwBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvpGrmUD6divgZHFZ62BUnx2kfMpv3jGdc9+5Uxx08M=;
 b=ZYd0li5BJUU0EUMNAliByEPvP8sJw8JDoEAOYDbR6eX4Qe6s2DKtm78U53ijHplV0a2xA1Cvo8hPkUzND2XzoG2sUFYXh1LXPxF5QAMnmfkWubaf2PiGCGcOCXB896DohXKnHd5+RvGfGcKjXJ3+gsIK2plDYOKlLQssXsfUAaG/lHRgW7L/vVglChdzAkH52oho+hR82GOHtOEnWVa5a2MUjahGiZcDOKSDAliD9WnsyesiAbm+sz5rF0r46XFm3gaMz6L4qGFfLKk3QU4v3BuWEnY6WT+MV11DZNEGs0tue4dkHcWjfaqzTD1XtNCR5PQ2ONxqI4eNKdK6zo77Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by OSZPR01MB7746.jpnprd01.prod.outlook.com (2603:1096:604:1b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 09:56:53 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 09:56:53 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, "'linux-cxl@vger.kernel.org'"
	<linux-cxl@vger.kernel.org>
Subject: Re: Assistance Needed with CXL Memory Region Creation
Thread-Topic: Assistance Needed with CXL Memory Region Creation
Thread-Index: AdtgqoH4aWCS14GjQ5iB7Jig2VQUVwHV4icwABCGhgABTj6kAA==
Date: Thu, 23 Jan 2025 09:56:53 +0000
Message-ID: <f43c000a-ea6b-40b6-80e7-5e79dc995a00@fujitsu.com>
References:
 <OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <OSYPR01MB535212BCA854FDCC57DFFC1C901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <67894f4e5ed6_20fa2946@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67894f4e5ed6_20fa2946@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|OSZPR01MB7746:EE_
x-ms-office365-filtering-correlation-id: f322d335-f7f4-4d3b-1b55-08dd3b9443ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlhXNkZlYXI2UXhwK2svS3lJWEUzU0xyc1E5MFVmdWZhRDdmaUxQbWxlN01W?=
 =?utf-8?B?N1BlMDQxWmJXaTd3dm16eEZuRzBDK0ZIK2IxUll0L0k3L09JbDQrbDN0YTVJ?=
 =?utf-8?B?ODVUNWJGK0F5NnQzU2dHRTZvbnlMUUVyUHlpM2xYSUdEK2R0Mkc5MkttazlR?=
 =?utf-8?B?M2F3ck5zS091MEM5MWZtZDNVbHRTUUpIQm5JZkFhQmNKQTR0bE5nQXBPT3dQ?=
 =?utf-8?B?SDZqZ3h6VkJkc1NySU1iTkdwOGQvRmMwRkFscVRsU1lvdERhejYrdFFTRk10?=
 =?utf-8?B?SnRBdU9NMlJkZGRjczA5NEpjUGZBNy9aQUdaQVA2L1NWMWlncmJDd0RiSncr?=
 =?utf-8?B?MUF1ZGpIVnRUalUrSGJxbmt4OTJWODF5ckpqL3ltc3dZRFliaGdKRzMxSGRK?=
 =?utf-8?B?TS9pYm0zeUVIQlN6VkVEeTdoM1p6VHFieWl3bGZ2L2lYeTMzWllrVlFTWWRi?=
 =?utf-8?B?NGxSUVNIQUdLOG1kanh6RnNNYjUyMWtFRGtFeElJd1ZzYjJTbUZxeWZOYUk3?=
 =?utf-8?B?Wmx5T3R6ZXlsVjNhYVJQVHhQR21FV2s5V3BaRDBISDRON3JOUktoUXRzNlA0?=
 =?utf-8?B?cDhRMHovT3lHTnBibDBtRmNoWnIrbGx5dHdQOXZ3aEhRbE1xS1dQZzNNajBB?=
 =?utf-8?B?Rm5ZOXBLc1NvcytRRVFGOTRBMXBlNE8zQnQyL1lmVUFydW40ejZjMlQ1ZzFE?=
 =?utf-8?B?NnZZRmpraWM0UE8vL2taaWVPYjdxUzFpUm5hcnJHd0VMT3h5MFRKQStXL3Uw?=
 =?utf-8?B?QTdHNWNHUmFNdGR1UEN5NFdtZXFjMUtrOCtleVRMaTZNU2NYb2cvMmNLS0NL?=
 =?utf-8?B?bFFZMW9SSjVFeS9DREU1RkVJaHlxU1ZKVU1GdzBnZmk2YmZKYkkrbStzNVp2?=
 =?utf-8?B?NFp3SjZ1RklEakxraHFxWmZSOE8vMGdsN0gwaXJ2SS9ha1BCdm9CeTNUMk0v?=
 =?utf-8?B?bVUvTEVCTTZhUU1ITjlzZFFic2lJMW5uc1RveFBpRkpVRjh6L1BIbWNHUmRi?=
 =?utf-8?B?NDBVbW5zUWh2YUxrMFJiOTNmalhzT3dTblo1ejBBTllZMndBMDBMS3RzemNE?=
 =?utf-8?B?dldDcHdWaGppOElZdkhPMWVFNGF5bjZkbW5uQ2drdVpDdFdZbG5yWmw3Zzht?=
 =?utf-8?B?NnJVdU9VWUM3ajY2NFFNTDdUYWoveDN1dWlldkZEcERYK1o3WFhLNWhOMEFJ?=
 =?utf-8?B?RmVtSDd6eFdka2VMQTB5LzVaWEZ5NGpBbTRhOWtXQmZSWFJ2azRJUzIwNGY4?=
 =?utf-8?B?MlpVVUEwOGFpVTdiTmxyU1dzbGY1UktlL3NCUmhEVEZUZFVFVGFxRkJMUTcy?=
 =?utf-8?B?T1hQdjFZKzROZll3SW8vdE41RzdzM3NaaEpXY3VJWnNLS3hNL0pPVWFtVVd5?=
 =?utf-8?B?ZEg5UWRYUSsxR09QRmtveDNYWXZ3b0EvanhXQkViL3NybXRtUFdsVjkvUDBY?=
 =?utf-8?B?MDJSVzRVK2hETnRxQVhHSW52dkVuOEFKQmVVd29GRkVBU3JmY0JsMXRwN1RL?=
 =?utf-8?B?YjFldC95VnhVdXJBaGtRb2ZKeDd3UExqV2NIR1NEZDhvZktkM2FsUWs2Rnow?=
 =?utf-8?B?ZGw1Rkh1U2pIWVRDUGViL3NZU2Zrb1FUR3JuZGtDVC9qUk5YTmVWWXh4Q3hL?=
 =?utf-8?B?WnFORmlxZTNmRldEL2p5V3lzYW9rRnZLNnNKYWRoNnVtKy9NUytkUzMyWUcx?=
 =?utf-8?B?c3crSm5kMmtmbDF1Qnd1bDJvNEszejJ3S0N3cmRRellMRUhITFl4OTh1MVBQ?=
 =?utf-8?B?YUFuVFpORzRFcDA3bGN5MjcxNVJWSUxmeERLQ3RCeWxhaXpFcDRES1liYjEx?=
 =?utf-8?B?TFROSzhuTWdkWURoOE1veG1Xd3kyYm9jaWEyNWo0OFBZcWRTbW91SnhQMUZ0?=
 =?utf-8?B?OVNINGpjQXBpWmlHd3JUa0YySWo5TFRMWEg1UGV5dWVhVFhlckhCUHBkSHh2?=
 =?utf-8?Q?/3zENoxMJJg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1566.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVYxNm9Tb0tsc0lBMnNTcTBBYXBlbis3dytpMWI2VzJ5anNrOXU0azlTV25j?=
 =?utf-8?B?cUR4NWNqbzlDZG15NE1GQ0pmNDR6VllBM3VvYm5DOVZmVEJyT1BOenhEQVF1?=
 =?utf-8?B?emh0NjNyUUY5bUFCT3lSRDdHOUM0VmZ2b24yOVBsOEJrdHNQM2FIMGpHd2do?=
 =?utf-8?B?Sy9qd2p3dmc3TklEUGh5YVNKcFU0ZFdEL1RVUHNxVUxUZWNRV1ZjRDdkU3Zt?=
 =?utf-8?B?aEVVczZqem9sVlRMNC93VGI0cngzaTdENkRaTmFVKzlnMnlOVXNMMmdtak01?=
 =?utf-8?B?YzE0L1FCYVd3S2JtZWgyZnBQR2k3U0RBNFpVb0d3N1d2L2c1TEY5dWw1Z1JW?=
 =?utf-8?B?b1FidHErblBoQnpwSjNXaFc5bTNxQ0xxc3NrQ3ROQTBLNS9uak1ZTllWRjRJ?=
 =?utf-8?B?WGZiWFJaQVpNS0srS1YzejRpU2loTEQza1dwcDJyL2RJNGoreUxuSy9IVWhj?=
 =?utf-8?B?YUkyK0E0eExINUZyZlpGdVo5Tktlc2NZY1NzYTlmOHozYytXN0dMVUpYL1ll?=
 =?utf-8?B?czl5WEhQK1c2WjBucWk0cTZpS01kZVArTW9tZGJENkZGVEhySXA5akExNWVM?=
 =?utf-8?B?cjMyQk5IUnZWc1hpeEp2Q0hrMUFaaGRYYlhlWTVJTlkyK2d5N09KbFNFM3Bv?=
 =?utf-8?B?eFB2MTVkK2NkUFZRb0V4bHo5SjBsWWhOcGM4Wmo1U0JLS2g2d0VlZlNJbXFx?=
 =?utf-8?B?NjRKd1ZobDUzeU8rOGZyNnZOU0JEelhPK1BRVkNrYnJRNjNmQ29HOXFOOVVo?=
 =?utf-8?B?RHduRlo0MTAwUTR5WXhtWUZTbmFuVkY4b25pWGlRNzg3VXc4REVMSUFSbEFD?=
 =?utf-8?B?eGgvekFLUEorS1M5TC9EZXBSN012Vlo3VlhCa3N1YlUxSERWY0NKcWFpOWdh?=
 =?utf-8?B?MnJJSGNkbHJQd1M0T1dBTjJGVkpMTzdBcmZFTmdQS0g1OFM0ekV6cHJhQ0Nx?=
 =?utf-8?B?dElOU2YyRkxET2FOK0VlMnhacWJTc1NoT2hGaGJZMnVZRjI4Si9Jajg5RDZv?=
 =?utf-8?B?UHRmcUZZbUh5MEl4Mk4yRTYwZUcyd3ZEdCtySUFvZHc2ZjZ4b0JqdVMxd1Bz?=
 =?utf-8?B?d0VONS9BN24yU3RaRlV4UTBQMEJqNUo5dEh3NGJNZFc2ZEVJN2VNaVAreXBo?=
 =?utf-8?B?RGFGOU02WDNkR0tCZWpuc1N0QmR3c3VsVUlQc0p3TytaTzY2dVZDVHplMm5O?=
 =?utf-8?B?cDg3WmtEQi9hUVY4cjMzKzFnSS9aSGE1Y3V2K0dmTDViWmJiSGl0RkpKRUVn?=
 =?utf-8?B?aVhxNmY5MUhrTEdmSy9sT3pYcVpqeVJGUDY2YW53V1d0THd0VVEySjJTT0VD?=
 =?utf-8?B?cm8xd2FhWXdiMEdBWGJkOXFRU2JkeWtmVmVwTEtucUgxazVjaStsSkUzbXkx?=
 =?utf-8?B?ak1GS1Z0WThlNWhBeTh6TjlyaTQ1bVNxOE5wV3BwYnNvdDZCMTAzZ0tleFI0?=
 =?utf-8?B?WWd0VlJFSlo3V3pERmgrcVVITGtTTWJsMGFVdUV0VnhVMVhyMm8zbGtKVWFS?=
 =?utf-8?B?Wkc5RXdSQktLM3NzR1FORlNOWW5JN3dKNmc3T1padTI0b2hxUDFRaGZ2aTA2?=
 =?utf-8?B?MlFsUWFDeEVjTDFoMkFBeTBmcXp6VWo0d1djTFVnUlZXNlhBRWp0eCtJSHpl?=
 =?utf-8?B?L0tnR3NHdXZDMm0yMEd6cDJOa1cxZTZ3VWhVaURqYm9mUWhiZWpPWVYzV3Z3?=
 =?utf-8?B?ZWlaNm4zTWFCOTFmaVhTSmN3Nk95L2pGK3orWG16V29WVTI5TWdFUGtLNitE?=
 =?utf-8?B?dTk4NGp1QnpQUGJKakZZdFdwdndlWmNiZGVkOUJ6OXV0R3JvdGhlRnRPUzJm?=
 =?utf-8?B?NVIyb3NyU05YQWNCV0NFYUw1T0M1RHFmb2RXQVVLVjJOMXd0QzhyaC9jWVR5?=
 =?utf-8?B?eFo1WnVwVExRTjVmOWUraEFTWDdEcU5yMUpGRlZNN0J6VnpGanJ3Mit5dE1U?=
 =?utf-8?B?cHFZVHZQeVJycm9wY0FkYVVCVDRRRjVaU0syVG1FQ0J4SFpuNVZ0YWNSL2oz?=
 =?utf-8?B?WnpNTHdURWtDRlBMWVFFbU5MOW5yajBQbWVEeUVyZHRUUWQ4QS9qTVZnRkU2?=
 =?utf-8?B?cGZLTm5jbG8rNm9ZMlJrWXNQbnJ6ekhLRlVZTnM5b0dTUm82Wng3V0RnWXdu?=
 =?utf-8?B?d1A2M1lvRzRMZmVYTlpFcXYyWkF6dzdNekFLVWJBY0NBY01VZTlFdEd4ZDVH?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DED0DAA4A7BF174B99E3056B40389E75@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h/QWypsJD3Dpa0Pl3v5SEmoWW+/5UrpD/f18AbJgDqTaculfOjZ7JFaSQwXn5VdxUySvYV3mp41UhzGZpws7mRUYRkQAKzR87PV41FJ7lAvLm9FEN8HNZsuCemndfTQ45Mkd3v5yI0ymhg0R8G1DFEBrcJi+FxnpnhN1fhAakMC4GP9yuiv/BdPasqQDe8PL/Z0I6kGo5EoaZBxCQccIYl07bdAOiWqCLnTqrX3uur37XwMEieaU2a56dmN65K/5BUTUVeSEgqnkkA7kwgpPt5Q00YfiMJM84Eu3XR1CIxiixYnZl2KkoV6XB0Kb7G7mA6/NQtT6SNSK4pQRVuKPui1RnIxI5vBiqLRxzdD5NTB2mdlcy4L6MMzThbN3+Ua6HK2dvgxGJQsvFGh4Cw6iA2pw8XL80oaSooCCLz220lqYclUKEBoUcENgEeCpyjCkCilF8BLgb0x644UBpErag3FAxDmuQVK7aF5Ra4Sd1BwUIxzOx9MflSpcOsvE7cZe/Fidx82ftRvZ+Gr2y7b3x1EWMpaO5v1Bd73rLj1sdI9j1NGMf2Lm/Gw2nRup7XdNsvQd+w2sGe086uGqN7i6AvLwJKzflBvcd8I0IpycRN4/nk6BY+tDWNRQFXLS9A7y
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f322d335-f7f4-4d3b-1b55-08dd3b9443ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 09:56:53.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rpc5vKg7RSfc9SplKcOwZ+WARCKehs00FqWhPa13Z5cKt4AqI/SBOZwhvLlBVKFlZILDTScGG+82mm62+246HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7746

SGkgRGFuLA0KDQpJIGhhdmUgYSBxdWVzdGlvbiBvbiBDWEwgcmFuZ2UgZGVmZXJyYWwuDQoNCk9u
IDE3LzAxLzIwMjUgMDI6MjYsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gWWFzdW5vcmkgR290b3Ug
KEZ1aml0c3UpIHdyb3RlOg0KPj4gUGluZy4uLi4NCj4+IElzIHRoZXJlIGFueW9uZSB3aG8gY2Fu
IHByb3ZpZGUgaW5mb3JtYXRpb24gdG8gaGVscCByZXNvbHZlIHRoaXMgaXNzdWU/DQo+IA0KPiBJ
IG1pc3NlZCB0aGlzIGVhcmxpZXIuLi4gaG9saWRheXMgKyBtZXJnZSB3aW5kb3cgb3BlbmluZyA9
PSBpbmJveA0KPiBvdmVyZmxvdy4NCj4gDQo+PiBJIG1ldCB0aGlzIGlzc3VlIGF0IGtlcm5lbCA2
LjEzLXJjNC4gQXJlIHRoZXJlIGFueSBmaXggZm9yIHRoaXMgaXNzdWU/DQo+PiBPdGhlcndpc2Us
IGFyZSB0aGVyZSBhbnkga2VybmVsIHZlcnNpb24gd2hpY2ggY2FuIGNyZWF0ZSByZWdpb24gdW5k
ZXIgdGhlIHNwZWNpYWwgcHVycG9zZSBtZW1vcnk/DQo+Pg0KPj4gSSdsbCBhZGQgc29tZSBtb3Jl
IGluZm9ybWF0aW9uIGJlbG93Li4uDQo+IA0KPiBUaGFua3MgZm9yIHRoYXQhDQo+ICAgDQo+PiBJ
IHRoaW5rIGN4bCBjcmVhdGUtcmVnaW9uIHNob3VsZCBzdWNjZWVkIGluIHRoZSBzcGVjaWFsIHB1
cnBvc2UgbWVtb3J5IGFyZWEsIGJ1dCBJIGNhbm5vdA0KPj4gdW5kZXJzdGFuZCB3aHkgdGhlIGFi
b3ZlIGNvZGUgcmVzdWx0cyBpbiBhbiBFUkFOR0UgZXJyb3IuLi4NCj4gWy4uXQ0KPj4+IEJlbG93
IGlzIHRoZSByZWxldmFudCBzZWN0aW9uIGZyb20gL3Byb2MvaW9tZW06DQo+Pj4gPT09PQ0KPj4+
IDg5ZDUwMDAwMC04OWZmZmZmZmYgOiBSZXNlcnZlZA0KPj4+IDhhMDAwMDAwMC0xODlmZmZmZmZm
IDogQ1hMIFdpbmRvdyAwDQo+Pj4gICAgOGEwMDAwMDAwLTE4OWZmZmZmZmYgOiBTb2Z0IFJlc2Vy
dmVkICAtLS0tLS0hISEhDQo+Pj4gZmQwMDAwMDAwMC1mZDAzZmZmZmZmIDogUmVzZXJ2ZWQNCj4+
PiA9PT09PQ0KPiANCj4gVGhpcyBtZW1vcnkgbWFwIGlzIHNheWluZyB0aGF0IEJJT1MgY3JlYXRl
ZCBhIENYTCBXaW5kb3cgIkNYTCBXaW5kb3cgMCINCj4gQU5EIGl0IHBvcHVsYXRlZCB0aGF0IHdp
bmRvdyB3aXRoIGEgQ1hMIHJlZ2lvbiBtYXJrZWQgIlNvZnQgUmVzZXJ2ZWQiLg0KPiBUaGUgd2lu
ZG93IGlzIGZ1bGx5IGNvbnN1bWVkIGJ5IHRoYXQgZXhpc3RpbmcgQklPUyBjcmVhdGVkIHJlZ2lv
bi4gVGhlDQo+IGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhlIENYTCBzdWJzeXN0ZW0gcGFyc2VzIHRo
ZSBCSU9TIGNvbmZpZ3VyYXRpb24gYW5kDQo+IGNyZWF0ZXMgYSAiY3hsX3JlZ2lvbiIgb2JqZWN0
IGFzIGEgY2hpbGQgb2YgdGhhdCBTb2Z0IFJlc2VydmVkIHJhbmdlLg0KPiANCj4gSG93ZXZlciwg
Zm9yIHdoYXRldmVyIHJlYXNvbiBpdCBsb29rcyBsaWtlIHRoZSBkcml2ZXIgZmFpbGVkIHRvIHBh
cnNlDQo+IHRoZSBDWEwgY29uZmlndXJhdGlvbi4gSWYgdGhhdCBoYWQgd29ya2VkIHRoZSBmbG93
IHRvIGNyZWF0ZSBhIG5ldw0KPiByZWdpb24gaW4gdGhhdCBzcGFjZSB3b3VsZCByZXF1aXJlIGZp
cnN0IGRlbGV0aW5nIHRoZSBCSU9TIGNyZWF0ZWQNCj4gcmVnaW9uLg0KPiANCj4gU28sIHRoZSBi
ZWhhdmlvciB5b3UgYXJlIHNlZWluZyBpcyBleHBlY3RlZC4gWW91IGNhbiBub3QgY3JlYXRlIGEN
Cj4gY3hsX3JlZ2lvbiBpbiBhIHNwYWNlIHRoYXQgYWxyZWFkeSBoYXMgYSBCSU9TIGNyZWF0ZWQg
Y3hsX3JlZ2lvbi4NCj4gDQo+IFRoZSB3b3JrIGluIHRoaXMgcGF0Y2hzZXQgWzFdIGlzIGFpbWVk
IGF0IG1ha2luZyBzdXJlIHRoYXQgZXZlbiBpZiB0aGUNCj4ga2VybmVsIGRvZXMgbm90IHVuZGVy
c3RhbmQgdGhlIEJJT1MgQ1hMIGNvbmZpZ3VyYXRpb24gaXQgd2lsbCBzdGlsbCBhdA0KPiBsZWFz
dCB0cmFuc2ZlciBjb250cm9sIG9mIHRoYXQgYWRkcmVzcyByYW5nZSB0byB0aGUgZGV2aWNlLWRh
eA0KPiBzdWJzeXN0ZW0uDQo+IA0KPiBbMV06IGh0dHA6Ly9sb3JlLmtlcm5lbC5vcmcvY292ZXIu
MTczNzA0NjYyMC5naXQubmF0aGFuLmZvbnRlbm90QGFtZC5jb20NCj4gDQo+IC4uLmJ1dCB0aGF0
J3MganVzdCBhIGZhbGxiYWNrIGNydXRjaC4gSSB3b3VsZCBiZSBpbnRlcmVzdGVkIHRvIHNlZSBt
b3JlDQo+IGRldGFpbHMgb24gd2h5IHRoZSBrZXJuZWwgZmFpbGVkIHRvIGFzc2VtYmxlIHRoZSBy
ZWdpb24gdGhhdCB0aGUgQklPUw0KPiBjcmVhdGVkIGluIHRoaXMgY2FzZS4NCj4gDQo+IFRoZSBv
dmVyYWxsIGZsb3cgaXM6DQo+IA0KPiAtIEJJT1MgY3JlYXRlcyBBQ1BJIENGTVdTDQo+IC0gQklP
UyBvcHRpb25hbGx5IGNyZWF0ZXMgcmVnaW9ucyB3aXRoaW4gb25lIG1vcmUgQ0ZNV1MgcmFuZ2Vz
DQo+IC0gQklPUyBidWlsZHMgRUZJIG1lbW9yeSBtYXAgd2l0aCB0aGUgQ1hMIHJlZ2lvbnMgbWFy
a2VkIEVGSV9NRU1PUllfU1ANCj4gLSBMaW51eCBib290cyBhbmQgc2VlcyBFRklfTUVNT1JZX1NQ
ICsgQ1hMIG92ZXJsYXAgYW5kIHdhaXRzIGZvciB0aGUgQ1hMDQo+ICAgIHN1YnN5c3RlbSB0byBh
c3NlbWJsZSB0aGUgcmVnaW9uDQo+IC0gUmVnaW9uIGNyZWF0aW9uIGlzIG9ubHkgYWxsb3dlZCB3
aXRoIGZyZWUgY2FwYWNpdHkNCj4gDQo+IFRoZSBrbm93biBidWdzIGFyZToNCj4gLSBDb3JuZXIg
Y2FzZSBDWEwgY29uZmlndXJhdGlvbnMgdGhhdCB0cmlwIHVwIHRoZSBkcml2ZXIgKG1lbW9yeSBz
aWRlDQo+ICAgIGNhY2hpbmcgYW5kIENYTCBpbnRlcmxlYXZlZCB3aXRoIEREUiBhcmUgY3VycmVu
dCBleGFtcGxlcyBiZWluZw0KPiAgICB3b3JrZWQpDQo+ICAgIC0gUmVsaWFibGUgZmFsbGJhY2sg
dG8gIkNYTCB1bmF3YXJlIiBiZWhhdmlvciB3aGVuIHJlZ2lvbiBhc3NlbWJseQ0KPiAgICAgIGZh
aWxzLCBzaG91bGQgYmUgYWRkcmVzcyBieSBbMV0uIEEgdGVtcG9yYXJ5IHdvcmthcm91bmQgaXMg
dG8NCj4gICAgICBkaXNhYmxlIHRoZSBjeGxfYWNwaSBkcml2ZXIgc28gdGhhdCBobWVtX3JlZ2lz
dGVyX2RldmljZSgpIHNraXBzIENYTA0KPiAgICAgIHJhbmdlIGRlZmVycmFsLg0KDQpDdXJyZW50
bHksIHdlIGVuY291bnRlcmVkIHRoZSAiQ1hMIHJhbmdlIGRlZmVycmFsIiBpc3N1ZQ0KWyAgICA3
LjcyMjMzMV0gaG1lbV9wbGF0Zm9ybSBobWVtX3BsYXRmb3JtLjA6IGRlZmVycmluZyByYW5nZSB0
byBDWEw6IFttZW0gMHg4YTAwMDAwMDAtMHgxODlmZmZmZmZmIGZsYWdzIDB4ODAwMDAyMDBdDQoN
CkFmdGVyIGxvb2sgaW50byB0aGUgY29kZSwgSSBmb3VuZCB0aGF0DQpJZiBib3RoIGN4bF9hY3Bp
IGFuZCBkYXhfaG1lbSBhcmUgZW5hYmxlZCwgdGhlIGlzc3VlIG9mICJDWEwgcmFuZ2UgZGVmZXJy
YWwiIHdpbGwgb2NjdXIsIHJpZ2h0Pw0KDQooY3hsX2FjcGkgd2lsbCBwYXJzZSB0aGUgQ0ZNV1Mg
YW5kIGFkZCB0aGUgQ1hMIFdpbmRvdyB0byBpb21lbV9yZXNvdXJjZSB3aGljaCBtdXN0IGludGVy
c2VjdCB3aXRoIHRoZSByZXMgaW4gY2x4IHJlZ2lvbikNCg0KICA3MCAgICAgICAgIGlmIChJU19F
TkFCTEVEKENPTkZJR19DWExfUkVHSU9OKSAmJg0KICA3MSAgICAgICAgICAgICByZWdpb25faW50
ZXJzZWN0cyhyZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcyksIElPUkVTT1VSQ0VfTUVNLA0K
ICA3MiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT1JFU19ERVNDX0NYTCkgIT0gUkVH
SU9OX0RJU0pPSU5UKSB7DQogIDczICAgICAgICAgICAgICAgICBkZXZfZGJnKGhvc3QsICJkZWZl
cnJpbmcgcmFuZ2UgdG8gQ1hMOiAlcHJcbiIsIHJlcyk7DQogIDc0ICAgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCiAgNzUgICAgICAgICB9DQoNCg0KSW4gdGhhdCBjYXNlLCB1bmRlciB3aGF0IGNp
cmN1bXN0YW5jZXMgaXMgdGhlIGN4bF9obWVtIGNhbiB0cmFuc2ZlciB0aGUgQ1hMIHJlZ2lvbiB0
byBkYXgva21lbT8NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gLSBJbmFiaWxpdHkgdG8gZGVsZXRl
IHJlZ2lvbnMgdGhhdCB3ZXJlIGNyZWF0ZWQgYnkgdGhlIEJJT1MuIFNob3VsZCBhbHNvDQo+ICAg
IGJlIGFkZHJlc3NlZCBieSBbMV0uDQo+IA==
