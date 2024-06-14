Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82A1946CA
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358727; cv=fail; b=Y3l2zogH/c6QFG1ALMJ2w/4Ulh0exbKxZ5oCodpfxy6rVHiCHynWa3zRE/eZHpNJO0F4IikYTUCsdj9jp50u6avwO75ql+t5V7Z3XwJD7Y98p0JyqbrJQjhBXEC9QBY19tDieqKKetgIZFNTRnAK8euRYaxHEfUfoTo8hZTmpY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358727; c=relaxed/simple;
	bh=xuyiNR/m92xOAfanXLabeTAtrjPeGHCmOLHBic47pLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lvwb1b9DUAzBSYEKw8jgR3XNaFOV3hrKwa43/IG8Huag4xwo5rqPyC8BH1PDrT3cCYQqkdoD0rnBhRIWGiQw5jB/kvmGjRIBUdGmmtnTtW3mBXAiFxoyDzjwufb30RKLxS+EGiImGG2+kSTq20D8g+JFqPPj4Gw5ZHE43ZYPpeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FEueNXF8; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FEueNXF8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1718358724; x=1749894724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xuyiNR/m92xOAfanXLabeTAtrjPeGHCmOLHBic47pLo=;
  b=FEueNXF81T0SEudSzBdbwPj6YQK4Y22OzL4tgAnX7jucChqzXjtujeck
   KWMaBJGviw89rVA+E7UWYOAtoulnXjTBXHrPugU8HQbE08Hl+cFA332UG
   V/Pdg6VF+BDIK6cQhjXR7Ef/J3C49TEH77KKGazaPFbAYpkbDVI89wGPT
   k5UxnYeLycDXOiAJIeQiqtT7QK+HreCxNYbeSCsnFt/KTIaH0sfkPJgAb
   JqLThHw2iB0vqlICe+CxriD11JeOC2BT3nJtzL3EZ3H+uRUNVJrTx3c9z
   jMIRAlm5ksVRNnFEwJsGpTq7PvOnEjOxmlA8nHnil4AYL0xK0fhlUN71v
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="122315668"
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="122315668"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 18:52:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfSkOituP+nEHkfpu6lI7p0TwFR8c7VnuRcIiC6SMZkOHdVmJdZ/hBOT83/xDJm2xjDcb7M1b6TOG69eqHORXNdCgv4RJQ1oVJ2CARAsQI9yRXooOxYMmjnO2w1vWSEhowG3swqk4PzAQJUlLH0JKISgL/2Xu9CeVgTVF1IVhV8rlFyc3UVh6fnI9XROgQ6v3OK0jf3dWd4kVXClXNLQT/ClmmVkAfJndCCa+AiSvbvPrVkuAuaMog7Z6HW8DWyQ5zyxEDa6hAGYzquNa2xqjWOHU1UC6+BNg2RYAVgXqSZoHhtiSjlIL3hOROlVxnO4KUXkZSclltKI/khgtKw9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi+uSqvg8oDW2QBu14Cn3QoIN7fiP/sZQC3XV/n6xiA=;
 b=KHvmusjJYjPCmW5Xb88mVyeP7wH0QcNW+JWww06uA3G2KvLlvmaqTbBLK0Ax1RsQMc2126JCX4FgBKvqt4XNYN1cfDNyE81M/ye1+dQZbN06neaihsUGvx3milQgYjlZ4mzU3iZ65GsNqJTciMKFXKIY9NegQFuM/i1hXVNgq3mgbNT6mPlAOIZW7sEGXxB0cRjwGDitMdtKRQ+PEQjXzmWur/+ajtRhHHKes2kIhePD2C2krdF1CGFK3EydvNbC3v/DwX8igbBHk75fstJJ/LcZ4lGPlGaHxruyzXd78eE6q0lENt4MPOliTi49OT1TR0ZJn976DwuA4MOKKgQv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB8343.jpnprd01.prod.outlook.com (2603:1096:400:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 14 Jun
 2024 09:51:56 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:51:55 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH v12 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Thread-Topic: [PATCH v12 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Thread-Index: AQHavhbGmolzw6IKrEWJ6qyZMfCnzbHG7gqAgAANr+A=
Date: Fri, 14 Jun 2024 09:51:55 +0000
Message-ID:
 <OSAPR01MB7182B37FB0600712947C6C2CBAC22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240614045611.58658-1-kobayashi.da-06@fujitsu.com>
	<20240614045611.58658-2-kobayashi.da-06@fujitsu.com>
 <20240614093027.0000251f@Huawei.com>
In-Reply-To: <20240614093027.0000251f@Huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=072e9b2e-a886-4512-a83d-43abfd8dbbf3;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-14T09:19:32Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB8343:EE_
x-ms-office365-filtering-correlation-id: 099284a8-c482-46fc-222c-08dc8c57a03e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230036|366012|376010|1800799020|1580799023|38070700014;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dmkwS2V0U290YnZrTXVYc3Q0SHBwUW01MDYrSVh3TkM3R0dWSTVCSXFT?=
 =?iso-2022-jp?B?RDkxT1FrQ3lMN25Pd05maEpPaTRZYVo4R2ozM2xLMGR5c2luYzZHdjZC?=
 =?iso-2022-jp?B?YnNMNEVWMnRwZlhzYkJ5U1FkUXVUK0NIdjlxZ205aEJpYnpmL05YL05C?=
 =?iso-2022-jp?B?WTRTdDRMbGQzalBCb3NPR0ZONUNLTjJnZFEzSWVqQVRDMTNXeExwLzVq?=
 =?iso-2022-jp?B?RHgrLzRKMThDcFFCdG5hdzFNVmRMc2dsYTc3dHI1d3J3TExYWEZzQ2NJ?=
 =?iso-2022-jp?B?Zk16U2p0QWNwcGFRM3JKTWdPMkUwMUQrUUkyaHcvWTEreGRweFV2Mmht?=
 =?iso-2022-jp?B?TG10VXFRVWZqcjJoQk5VNWcrRWlLWkp6OEs0T0Z0NXpsWVRabUlYUUJp?=
 =?iso-2022-jp?B?N1lFTDNXbHk2TVVLTWJmSGtaV1dIdHhtcHRzZUZBcE53NjlHcXBOUFFY?=
 =?iso-2022-jp?B?cDNRcUhibWVKb2ZaMVl5YS9GYS9ZbGNMY3JQYTBTaVp5TXEvN3NUeFYx?=
 =?iso-2022-jp?B?TktKb3g4SjdkRnpyVTRPZnQwZ3kwdkl6cTFYc1BxaWhoai9RakRtUmlC?=
 =?iso-2022-jp?B?aUFLQXlEaUtOeVAyUWo5UkRDdGlRUFNJeitscGxhRFBWK3k0a0F0OHJU?=
 =?iso-2022-jp?B?eHVzbkxVbWd4WHRIR2JYMUl5cTBza2JDQ1IxMkNsS1pnODg4T05tUHpx?=
 =?iso-2022-jp?B?YUpuTTQ4ZFg3UTdlYk1ydE1BRnRpeDdWR21mSWZvT04xK1YzcVZNQlZ5?=
 =?iso-2022-jp?B?MXBQdnB0Q3hWQ0tnUGZYcC9qc3QzenVQWDViS3hOMlZWNnRJTFkrcXZk?=
 =?iso-2022-jp?B?ZklHb1FSa1FQQm9jTEJ1UDYyUTcvdWdHRWF2Zk9HNkNNSHF5elU5Mnc2?=
 =?iso-2022-jp?B?ZThFMm5KaGk3UFFqR2ZQQkJpNjY0dmRYVWx2WWUwempFNW5JZXNyOE1Q?=
 =?iso-2022-jp?B?aXl4aHNsY1kvdWpQT1ZSVlZzWm9IVWN3bGQ5b2JiQS9GTkJQejBSWXhR?=
 =?iso-2022-jp?B?NVVSZWwvckhidm1lODZCb1lzcUZWeXR2RktFNzNmN2x6UDJQQ21zUlIw?=
 =?iso-2022-jp?B?R25yUnNQQ2YwN2crU241TnB1aVF4N2lLVHB5aXR3c0hMd1MzNCtOLyt0?=
 =?iso-2022-jp?B?aGdmV3ZaUVNGUFF5aktQcUdCWlFzVzY2aXpXbVhZbG15Si9nbWhmM2ln?=
 =?iso-2022-jp?B?dndqaFFmdDlVcG1hdklJZ1ArOStCWHZUaUV5VG01SEIzOUhMSEZoOWJs?=
 =?iso-2022-jp?B?UGtYNnRiMVlEL3NCZFZKdHZqRCtPd0ExVVhWMU0xOUpUbzRNSVcrYXE1?=
 =?iso-2022-jp?B?TldJVnJ0MmRoZ2VQREtHaUQwLzI1MU9MT0MyQUdmWThxZmNqTjlhZEp2?=
 =?iso-2022-jp?B?Tkw4S0syOWQzaktsckxOMmFXZHgrQUlsZjlvbWYxSG5pQWF2MHFiL2JV?=
 =?iso-2022-jp?B?WFNzOUFGNVRlekhlWmt4Nk4wT0NGZmVzSS85S0FWL2VoQVRYd2pZNlYx?=
 =?iso-2022-jp?B?TC9Za0FzZGxjZzVGU2pDcHlKSlBDcTFIajRYbUhlcUZZL2NJK1FGNUR0?=
 =?iso-2022-jp?B?UXo4ZTZpeXBkVUtSQ2ZUQjNhUlZxNnYxcmppWS9XYUZSZngzbVRnOTRN?=
 =?iso-2022-jp?B?L0hQZWRaL1N1cTVMemhOUFpHRDNqSkVIVVRhWkM4NCtna2E2S0NNWFYr?=
 =?iso-2022-jp?B?RXc3QXpBMDlFV05wNnpwaUdvN0g4RjcvZkpMSkdCY3RJaFFSVm5lbHdh?=
 =?iso-2022-jp?B?aURVS1E2Q2IwZkRiZ0kydTJCVTN3R2RSaWNXRFlDaVRoM1QwNVdPRGVq?=
 =?iso-2022-jp?B?VGRjOVZSSlNiclZocHE0Y21TSHduTlBMb1NvU3lxSytmcUFtOE5iVlBq?=
 =?iso-2022-jp?B?YUxFcXRFa3ZWSzZTbEZaOUZUNmh2dnFrSjh2Q1RYRHJiZnR6WnN3ckFP?=
 =?iso-2022-jp?B?UXY0dEhsY0crV0R5R3M3QlhCNEdnMEd4MjVBSmRYeXpVRWd4bmxUUHp3?=
 =?iso-2022-jp?B?WmZQRVJZeWN4dm1WU29lOWIzZ1JobjZhYXZnZzhJRWNKV25EeHhUbTlw?=
 =?iso-2022-jp?B?Qmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230036)(366012)(376010)(1800799020)(1580799023)(38070700014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?enBJWisyVk9aSGhSdjBpeU5LTDRWd2NmMk1La0E5ckhvdkZndHQ3b2JD?=
 =?iso-2022-jp?B?alo4bTBxNU5vVjdtMlJZQzBneFd0Njgya1dMMC92Vk1wVWVQWXFqN3N2?=
 =?iso-2022-jp?B?dVNoZkR6ZWlKWHBuNUNwZ0N1ZWVVSEp4NnVDVVZnRjdJVzlSc0haQzFl?=
 =?iso-2022-jp?B?UW5WWGhqckJVUGcwNnFwYi94QUhycUdhTElBbVlwUnpqcDBRR3lmTXN3?=
 =?iso-2022-jp?B?WXg5R0NwZHd5SDNDNVlLVzBIRnIxNDluelc5RHhhZXIveWhCUFlMYnBz?=
 =?iso-2022-jp?B?QnBzNTZ2dHNvcHlIMzlYYTJ1SkJJVEQ5Z2k1dXJubUJYakpMTjljNzVw?=
 =?iso-2022-jp?B?dk9UUDFiNUdNaHRkdEdBMHNlVFIwQ3dGYlpIa05CbGFyYVVubG1KOWdw?=
 =?iso-2022-jp?B?TEl6RXdMRDQwYXhxMEt3eDMxVGtHOUdSNm9iUUdnVFd3ZG9lQldxbXZ5?=
 =?iso-2022-jp?B?cnBlWVZFcytwYXorc3BkZWZuSmk0dmJUK0IzSURyUnNQOGorbnQvQXM5?=
 =?iso-2022-jp?B?cCtTYkhnUW1UM214YXptSzQ2M3hobzVDZEZIdXdQekxZR1h5YVROQ2Fu?=
 =?iso-2022-jp?B?TlVud0tFSE1McmxGQUdsSWN0cjRmU0gzVW9aUmFXN3hBNXYwaXNUaXZ2?=
 =?iso-2022-jp?B?TTVORkJuU2M1UzhiTUZVZVk5VXp1bzNJRVBFR3ZzSW83ZlJYRWhTcThs?=
 =?iso-2022-jp?B?eVQzYm1BS01oRTVlWUVxWm1XZDN3K3hxVXU1QWVkWWppcFlKM2NJeEVy?=
 =?iso-2022-jp?B?TEJYczEyQ251eW4rem1WWUp0UG9JdzM3Q09NU0F4aDFZYWFhNW9sWnk0?=
 =?iso-2022-jp?B?Zms5N2lISE5iU3l6dnVmNEh1bzdvS2w5KzB5YW5IMnBGQ0RxL0o1NWwv?=
 =?iso-2022-jp?B?Q2EyRkNkWk1yTWJXVzIvV3ZlTDZ3dlByU1AvMFVxK21nTGFnZEVQaWc2?=
 =?iso-2022-jp?B?eFRhbjZCSjJ1djRVWFFvdXJjanlmL3BQRERqTWZVc0Fxc0gvLzVCVEVu?=
 =?iso-2022-jp?B?Vm4rY3hQWDgvaTBpMTczSndIMmZHZlF4VVJuZzRYb3lTWkpwN3Nzb2g1?=
 =?iso-2022-jp?B?WlRPVFBiL3FFY0NUV3ZQbGVJMzZKTE5yaVRNcHloLzhENGpnb25pcUZm?=
 =?iso-2022-jp?B?RkVha09xWHp6b003Uzlta3NaYmFTUXhLYmVrajltSjUvODFYQXlOTWk1?=
 =?iso-2022-jp?B?QmxJdEVqOXNVVWZZckVaMzExYVV0OFpLRUtSZHJ5aVZPb3hvMlJBakRk?=
 =?iso-2022-jp?B?UVRWUUI0SW52eXJRZUdOR0l6VkNlbWlFblNwUXB6NGR0bnRITDJNbk55?=
 =?iso-2022-jp?B?b3ZtUzB1M3hmN3BNOWp5WFlSWVcrMDJySWFTWDhlRGRKcUJERzkrTHlT?=
 =?iso-2022-jp?B?T1R2eThOam56ZVZ1SWlJMDNhMWJTVTRoQmEzNE9BRkNPUFlsNXlzeVZ3?=
 =?iso-2022-jp?B?VENzcjhaUVZTUm5lZzBpMWt3S0d5Y3NoS3FLK20ycDFTV1VUNm80Z2hG?=
 =?iso-2022-jp?B?K2ZKRFRyUEx2RDh0MFdLaWNGUHhpQmRDUEE1K3V6Y1M2bE1td3JMVTJs?=
 =?iso-2022-jp?B?RHowSEMwRytHVCt0SWs5QWtqeHBVd2ljKzBWK1ErWTZGUzVTVHNDaHdW?=
 =?iso-2022-jp?B?Vzljakhrd1pCdmsrVGlyMEJZdDlNZUdvOW5NODBUN01NRUdyRDgxZmx1?=
 =?iso-2022-jp?B?TVhuOEFzbFo5cUxtUW9zNGs3b2o5THF2dnU0RVUrTitqTWJjbVNoZTRP?=
 =?iso-2022-jp?B?bWM4Z2tOS0RlMTg4bGhnTkZiZ1NhMXRiTTA0aG1TSkVLR05nWXl4YzQy?=
 =?iso-2022-jp?B?UzF1YkJMUCtHQVpZMjRnZnZrcnpZb0ZzaEdLZTRkc3lYUmZuV05OQ3N2?=
 =?iso-2022-jp?B?YVpuSkZ2UEhkQkkzNlp0eVNrN2toRE5zaEJxeEE0UVhBNmQ0a2dXVXl0?=
 =?iso-2022-jp?B?V0J4NC90ZTRiT05yc2E2aDdTa2RIWFlmaWhEZXpzdk8wNHRxR2d3VU02?=
 =?iso-2022-jp?B?MktTRFhtdGhON29idVRWR0F1TkpTRkFJb29BVmd3Y1ArTWY2K2RobFBV?=
 =?iso-2022-jp?B?R01SU2dDWGNVQnprRll4bHNiV3k3dm16ZEx0UUEvM0QwYkpPaU03VXYw?=
 =?iso-2022-jp?B?V3ZaUXhtc2xlNHhCRGR1Z0lVT1JEYVVFNnNRaTdZa2pMVzNXVCtZVm1p?=
 =?iso-2022-jp?B?T2hseXN5Y0dLcWZsM1hLdE5SUTNoc09YaTVjaWtyK0hUTUpsMjJZRmtt?=
 =?iso-2022-jp?B?d0F5d1ppUDhvV1RPM3JIZU9SQ0JBcVVaUVNQdFVYRzROanA4eElMREY4?=
 =?iso-2022-jp?B?ZWZNNE1qUlpMYlRiVzZQZmlDaGpyUk9Kcmc9PQ==?=
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
	a/mJ6BmTePwftAo2s/a+z45tOlGRgg9TA0SDXZ1bb200Jf3FtfdL2TOA+FkAhJAtEFHjR24uaiozlr3Ain2zgx2ZYrg6IAiZod+usBCSXOZClOQ+WR72zT5vISy1qA55Eanej1Gp68eIT2X9daObb3m5mPsU7NMwyWsrIVK9rP9qpURQMxZdZEYmi9D/MfGhKppGF0GRINEwOiBI4Pr7U1lxHCm4+9g5MuNUPdeRi9U56qbloscilahDPxlnxQ45qrRVfCwbj+rfrzT5vVjIqu3a+bY7CGNaIwVgkEI1wgr+HLr6vRdDXzlBJiVhnN3OICMgj0avtnMzseNhxdw36kMXUspsMC+yhVQscVofBi4+Q/ZyMl60RXB1Xa8OXAgYTnjQg9aKbjZWeCGf0CKWQsTjAumlOVTg52uRUhFsZ3f7CJaeH6itnwaynkbm4kLXt2IYjelf9/TSuFgwOLWy8ws9I0oQB5W5jBDEOjzjMtgQbiHW6kGRD8AwbJqvHXSpimCsc4sRpSWtGTtONmps0q1HqI/hirY0nAMsMfMNbjvG6ggIXtFu2YdgrqZY6gUWw/uN74xGQ8PKIWcr+gOs28yuMOGB4Zw5U5JWIREQ4NqSJcp+VVgNCQTBEGi3VWA7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099284a8-c482-46fc-222c-08dc8c57a03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 09:51:55.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YS+A5xdqvwh0mNsyIX0NkU+mrCwUmowZBNuErpC82o/nZ/nsrwf62HpGPbST38ZMucGfh68CvyYUkM2MmOpslY2F5Zm9jLMzw8G7rF0NUeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8343


Jonathan Cameron wrote:
> On Fri, 14 Jun 2024 13:56:10 +0900
> "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
>=20
> > Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1
> > device link status information. By caching it, avoid the walking
> > memory map area to find the offset when output the register value.
> >
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> Hi.
>=20
> A couple more change inline.  Problem with evolving code is that as a rev=
iewer
> I sometime forget to check my expectations.  This now stores a variable i=
n a
> core structure just to use it once a few lines later. No point in keeping=
 it.
> Looking at that made me notice the error returns were wrong and unhandled=
.
>=20
Thank you for your kind review. I can't post the next version this week,=20
but let me check if my understanding is correct.

> > ---
> >  drivers/cxl/core/core.h |  6 ++++
> >  drivers/cxl/core/regs.c | 62
> +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       | 10 +++++++
> >  drivers/cxl/pci.c       |  7 +++--
> >  4 files changed, 83 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h index
> > 3b64fb1b9ed0..69006bde7ad5 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -74,6 +74,12 @@ resource_size_t __rcrb_to_component(struct device
> *dev,
> >  				    struct cxl_rcrb_info *ri,
> >  				    enum cxl_rcrb which);
> >  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> > +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct
> > +cxl_dport *dport);
> > +
> > +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
> > +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> > +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> > +#define PCI_CAP_EXP_SIZEOF		0x3c
>=20
> I'd like a follow up patch making these defines apply for all usage of th=
ese fields
> in the PCI core code.  Right now there are pointless hard coded values.
>=20
Does this mean that you want me to post another patch later that=20
defines PCI_CAP_EXP_SIZEOF to replace the hardcoded value in the PCI core c=
ode?
If so, I'll create a follow-up patch in the future.

> >
> >  extern struct rw_semaphore cxl_dpa_rwsem;  extern struct rw_semaphore
> > cxl_region_rwsem; diff --git a/drivers/cxl/core/regs.c
> > b/drivers/cxl/core/regs.c index 372786f80955..96c2a289cfb7 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -505,6 +505,68 @@ u16 cxl_rcrb_to_aer(struct device *dev,
> resource_size_t rcrb)
> >  	return offset;
> >  }
> >
> > +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct
> > +cxl_dport *dport) {
> > +	resource_size_t rcrb =3D dport->rcrb.base;
> > +	void __iomem *addr;
> > +	u32 cap_hdr;
> > +	u16 offset;
> > +
> > +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	addr =3D ioremap(rcrb, SZ_4K);
> > +	if (!addr) {
> > +		dev_err(dev, "Failed to map region %pr\n", addr);
> > +		release_mem_region(rcrb, SZ_4K);
> > +		return CXL_RESOURCE_NONE;
>=20
> If you hit this then the value returned will be all fs.
> We are treating and offset of 0 as the error return below.
>=20
I will change the return type to int and return 0 on error. Does this match=
 your intent?

> > +	}
> > +
> > +	offset =3D FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr +
> PCI_CAPABILITY_LIST));
> > +	cap_hdr =3D readl(addr + offset);
> > +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) !=3D
> PCI_CAP_ID_EXP) {
> > +		offset =3D FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK,
> cap_hdr);
> > +		if (offset =3D=3D 0 || offset > SZ_4K) {
> > +			offset =3D 0;
>=20
> 			offset =3D CXL_RESOURCE_NONE;
>=20
> > +			break;
> > +		}
> > +		cap_hdr =3D readl(addr + offset);
> > +	}
> > +	if (offset)
> > +		dport->rcrb.rcd_pcie_cap =3D offset;
>=20
> As below - this storage in the rcrb structure no longer has any purpose. =
We can
> use the returned value from this function to get to it in the one place i=
t is used.
>=20
>=20
>=20
> > +
> > +	iounmap(addr);
> > +	release_mem_region(rcrb, SZ_4K);
> > +
> > +	return offset;
> > +}
> > +
> > +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev) {
> > +	void __iomem *dport_pcie_cap =3D NULL;
> > +	resource_size_t rcd_pcie_offset;
> > +	struct cxl_rcrb_info *ri;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> > +
> > +	port =3D cxl_pci_find_port(pdev, &dport);
> > +	if (!port)
> > +		return -EPROBE_DEFER;
> > +
> > +	cxl_rcrb_to_linkcap(&pdev->dev, dport);
>=20
> Sorry - with all the changes I'd missed this previously.
> There is no longer any point in storing the rcd_pcie_cap in ri.  Just use=
 the
> return value from the above to fill a local variable and map that here.
>=20
I was too focused on fixing the issue. I'll remove the variable.

> 	ri =3D &dport->rcrb;
> 	rcd_pcie_offset =3D cxl_rcrb_to_link_cap(&pdev->dev, dpor);
> 	if (rcd_pcie_offset !=3D CXL_RESOURCE_NONE)
> 		dport_pcie_cap =3D devm_cxl_iomap_block(&pdev->dev,
> 						      ri->base +
> rcd_pcie_offset,
>=20
> PCI_CAP_EXP_SIZEOF);
>=20
> 	dport->regs.rcd_pcie_cap =3D dport_pcie_cap;
>=20
> 	return 0;
>=20
>=20
> > +
> > +	ri =3D &dport->rcrb;
> > +	if (dport->rcrb.rcd_pcie_cap) {
> > +		rcd_pcie_offset =3D ri->base + ri->rcd_pcie_cap;
> > +		dport_pcie_cap =3D devm_cxl_iomap_block(&pdev->dev,
> rcd_pcie_offset,
> > +
> PCI_CAP_EXP_SIZEOF);
> > +	}
> > +
> > +	dport->regs.rcd_pcie_cap =3D dport_pcie_cap;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dport_map_rcd_linkcap, CXL);
> > +
> >  resource_size_t __rcrb_to_component(struct device *dev, struct
> cxl_rcrb_info *ri,
> >  				    enum cxl_rcrb which)
> >  {
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h index
> > 003feebab79b..b1fca98ddf8c 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -230,6 +230,14 @@ struct cxl_regs {
> >  	struct_group_tagged(cxl_rch_regs, rch_regs,
> >  		void __iomem *dport_aer;
> >  	);
> > +
> > +	/*
> > +	 * RCD upstream port specific PCIe cap register
> > +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> > +	 */
> > +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> > +		void __iomem *rcd_pcie_cap;
> > +	);
> >  };
> >
> >  struct cxl_reg_map {
> > @@ -299,6 +307,7 @@ int cxl_setup_regs(struct cxl_register_map *map);
> > struct cxl_dport;  resource_size_t cxl_rcd_component_reg_phys(struct
> > device *dev,
> >  					   struct cxl_dport *dport);
> > +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev);
> >
> >  #define CXL_RESOURCE_NONE ((resource_size_t) -1)  #define
> > CXL_TARGET_STRLEN 20 @@ -646,6 +655,7 @@
> cxl_find_dport_by_dev(struct
> > cxl_port *port, const struct device *dport_dev)
> >
> >  struct cxl_rcrb_info {
> >  	resource_size_t base;
> > +	u16 rcd_pcie_cap;
>=20
> This is no longer needed I think after the suggested change above.
>=20
> >  	u16 aer_cap;
> >  };
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
> > 2ff361e756d6..62343a5a39ff 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -512,10 +512,13 @@ static int cxl_pci_setup_regs(struct pci_dev *pde=
v,
> enum cxl_regloc_type type,
> >  	 * is an RCH and try to extract the Component Registers from
> >  	 * an RCRB.
> >  	 */
> > -	if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT &&
> is_cxl_restricted(pdev))
> > +	if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT &&
> > +is_cxl_restricted(pdev)) {
> >  		rc =3D cxl_rcrb_get_comp_regs(pdev, map);
> > +		if (rc)
> > +			return rc;
> >
> > -	if (rc)
> > +		cxl_dport_map_rcd_linkcap(pdev);
> > +	} else if (rc)
> >  		return rc;
> Style wise, I'd put {} round this second leg as well.  It's common to do =
this
> when we have a mixture of single line and multiline legs.
> There are several examples of this in this file already so we should matc=
h local
> style.
>=20
Thank you. I'll fix it

> >
> >  	return cxl_setup_regs(map);

