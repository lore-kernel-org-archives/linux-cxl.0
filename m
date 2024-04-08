Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D2EDF
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544163; cv=fail; b=JRHLxTLMVU4Gkl833hmNcAleoQxJCK1dVhRCRViKliZvmy9WOuVybLX4n2aTI1uD87su6b7FCufzegPKXqMj49JPkWeb3qpcA5kCYcwQ6m3qbjpCASz84xeVt8HrTyw+H6Mho7ZoqBzA+kmGuMHrfA6PDnAqGFvmMjuxexsNV50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544163; c=relaxed/simple;
	bh=/XAMWIuFJMibhQZ8kxB0IYT/ceji0P1h6HJ9AvyZNrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FVjgLeqd/McmEeByQSB9Hv7ArvkS/c/Qy3h9Wq4w79KqqQBVhNYWFG9UFwUSSsDyIVIQoLaQpUcAnbHxNC5gJO1zX5ZvDHo4IrWEwZho9zOGJirYgNuPBh+ZHU08rbVlXXOKLdpJrw1m5KRarIrw4qCp6Wi46Dea/KyvtFzeU/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RshfitEC; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RshfitEC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712544159; x=1744080159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/XAMWIuFJMibhQZ8kxB0IYT/ceji0P1h6HJ9AvyZNrM=;
  b=RshfitECcc74fTpUbgHEYSDIwUd2HRZf239AZlBQGm2NzA3DytvWTn3H
   lry763ydLWNxL+Nr/n1IVjzOOYIXq0Yb3PINRDireM7CUt3btNuJRqfR0
   lmwmPI12PHPZNwad9fNu76WX+wGmj3pOwt3bUdJDLI/hu94+fnZOt3uNf
   rwRrhCxCdaKBm3LEHi+n/ivOl5w53h/oLSnxfsdvaWlSHG3Tqid1U9uRa
   8JudalADj1XcI+ls/iWSV/QfYrb6Gdc+mI3StP56rpxuIe5wLNkOczrFQ
   D4puQKUPo0i1NVuY/4hFrIzc6RUHTObemix5eav3CDWkxEcEQue+LT42C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="116987793"
X-IronPort-AV: E=Sophos;i="6.07,186,1708354800"; 
   d="scan'208";a="116987793"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:42:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YewGEbrJifx+DDXzu4Bp3dRnal08AsBsMWsxfgaWrg9hoH/p0p1+k7XxfGtFSzY3CwG25xvku9plajZ5r501F0je3U9XIqyhIaUqvOahgaKHl2nEV2Ehc6Qiii0jTHxeqDwfIhySQx+UlBNtel7wTZ1ttnAo+bLVHIpukoVTWiKo7heos2BkBSMuzKHQa5qVVfp3/TaoiVfx+8xov8ecdcUq70rFYbrR0I/96hJhc+vfk5AnkKQ7MtqbQP7v2+7hL3ukxU+X1Ah1K+RDvSlfESzJTsvPCSOzGwzTmSga7dcc59My8iXsCFlRIDjUflSQmMt10AqU6PnXRAVfa02MwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqrdXU3D2ZWw+nG4Lx8S6tuCEyO0wSrRmgWeoVgb0bw=;
 b=AFoT6PVRLrAAkpreacJHOmhPCRI2f63s/a0hUz6v/u1GusIXop/wP7U21izvLdPO3GE+p5rLkxa6BQcd0rMtDlcQzMhxHVjVagQSuvybyUU26bv+c8n94z94mMOz/kE6ShNLqg0y7Ry/E5Isx2ZHGPEimZ7XmSChG3xaX7PPicxmsTxL6+9kw8bbVhVbFSnc7llrbzxdfnDBkDI2pZkdjNoxSzHO7Xk5KO1jCAGZJQQ/tsVxC+AmCMzM0b7lgWNjAGeXD0IVP2ZjErBT4CVD1ZFO9WYoPdOdHHe9GMUo9Ve4bJKmiRsx2esMboMePfFBKHrAn5K3o8/EmqqrevCRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TY3PR01MB9932.jpnprd01.prod.outlook.com (2603:1096:400:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 02:42:25 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 02:42:24 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] cxl/core/hdm: rename interleave_mask to
 ig_cap_mask
Thread-Topic: [PATCH v2 1/2] cxl/core/hdm: rename interleave_mask to
 ig_cap_mask
Thread-Index: AQHahW1L41Gf/4wbf06EY/um73WdfrFWlU+AgAcbulA=
Date: Mon, 8 Apr 2024 02:42:24 +0000
Message-ID:
 <OSZPR01MB645312FDE6E13B7BD9653C928D002@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
	<20240403021747.17260-2-yaoxt.fnst@fujitsu.com>
 <20240403150611.0000180c@Huawei.com>
In-Reply-To: <20240403150611.0000180c@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=3b05e3bb-27fc-4b0d-8f06-c5eec33e184d;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-08T02:39:21Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TY3PR01MB9932:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LwkmVLYDSn/i1LL+cEZilKJ0UmnplwBz5+gvKR5KpFcG7w8BllT+7D0QnBYqOTEBX5txc2kRlO9VSvPeQB4dOTf1zGqr3ugetR7v8dOu+iLvea4Sh7gngUXsMvVTvPS6TSY/cHokKygfjNji340DbYa8whfMrjxhreWFUrwcG5B+ZME7IgZrMhAF2Qy5K2fTPJRl96ziYouH6jwK+QptGebrNpKOEaDJj0pctI033GAJXmDVqkG/jtX6eIJLgai5L9ef3AquNFMQ3vbqdTukP9JMUNCjWNpaI3YpL4MYotkMH82YPI4WTMYSmQLCtygPP7ncsHhBkU2bRsxBrofdes5yj05sxjY4Vilh8sVlwjCj4osFKhba2SUioUYtDv2Td76taFMvBsa2BIQW9DQQ9vvVQBv870IQmM+mIo0ygBwqhf0wg/w96o8q/Bgjjm7MjgbqbTLGAk9/yVCWiAauuOeBXipr1AZjEyT14uSoomRpKUfLqTQW62WRneQV/8eoTY42crlNRaorGuIpkVeo9LSV+7/N4ID40cd05ZUleyL2xmBSMDP3kfB59PX9PBTgTK2aUyknIWmtfxI9exN/Y0HYhU6Efz68c8mCmbDcZ21oBD/aAVHFx1U7JvgBM6F34KUbvKbyAQbORnfydG8j8CbwknwkKPaekpJD24f/u1mg2ZlB1XseqqQ7KEKlgCwgPOVX98FJ3HPQPVgzgfc5TQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?N1FhQW9MUnIwVEhFQWRMaXpFWFBCL1p0Q0RiZ0FvdDFDMm9QSEpxb1RZ?=
 =?iso-2022-jp?B?K0JKZWNmOUEwb2l0L1JkdEJCOG1WejBxVkQyT3U4SUxWSElEZmYwY2RJ?=
 =?iso-2022-jp?B?bEhwUDMvTmd1TTB6TUgwRnlSS3lGMHRpMDBsUmVlZmlPdUY0TkpuZVo1?=
 =?iso-2022-jp?B?K0YzbHEybE1kRUY2L0pPVWlQZm1va0loaXdsTkdlUnprWHgzWi9JTVNp?=
 =?iso-2022-jp?B?V09EbmxQd055ZnVEVUF6aEVCME0xeDE4Yk95ODByYVdnK3l5RXU5Vlhw?=
 =?iso-2022-jp?B?cDZqQ2pBM0VOYTM1R1VkSWdtOEk0NnBhNjZTK2kyTTNwL3Vrdk9YRzQw?=
 =?iso-2022-jp?B?UkE5dXZaazF2OG1RUDRBQkZmQnpnOUtYVWp2KzB5TC9GS1ZUZE9qYmJG?=
 =?iso-2022-jp?B?WFF4VDBnbEdlMmpkRkpSNEFXd1Y3bUJFNndrNlczN1IzbHI1VXhjQTZS?=
 =?iso-2022-jp?B?Wk9qalJUUmMxOUJuVVlCb285YlVLa3pmaGhMS1NSSkNTRlg3QVVaZ1lU?=
 =?iso-2022-jp?B?WjlhbzdUQVJhNXFPY1dTNVBHRFlTcnZmTFJFUTA3cG5qVlhOQVBOTk1n?=
 =?iso-2022-jp?B?ZkoxTFJaMitxeUxXL3BqQjlpUndMbGFNWlZ6eGFDNi9henBlTzJFMTVR?=
 =?iso-2022-jp?B?a3NlYklsRTdseWxLaHVPRHFKS1p0Z1M5bEhLUzNLVklYNm1NVjdwYm5P?=
 =?iso-2022-jp?B?bXZzN0NDenQxOFAvaWFONGhUR1VjbTlZOVFabWdsK0RYRUxROWtSSXRl?=
 =?iso-2022-jp?B?eUtMSDF3Tk5PU21DOGN1OGdaLzE3TXV4TVFLbDJ0Y1ZkSlZmZm91R0lO?=
 =?iso-2022-jp?B?aFJ1Y1JsMU50T2k2ayt4RmlTTXp6c1lTVnowb0d4RzVNKzErM2o2U0V4?=
 =?iso-2022-jp?B?WFE1YXkyYTg3QjNIaU9SS3k5RlpvYWFGRUpDeENKVEVWWHlCS253OHQ1?=
 =?iso-2022-jp?B?cXYwSjJpKzg1SnVqWkJTTFhoV1hmcXk0cVY0N1haS1JQZmpVRnZCcS9U?=
 =?iso-2022-jp?B?SGVwNlMvWVlDNm80MjZnT21Fa2hrSVFxSFE1dWQ0ZzU1SmFzMk0xdGVk?=
 =?iso-2022-jp?B?SFkrdG1RanIxdlZHZk5idnp5UkZvdVBQT3o0RUlxN1hzZnVCclV0WFY5?=
 =?iso-2022-jp?B?RXpIVVMwbmh5WXgvODk5TzJaazQ2Y0hOMU1FNVE1VGJueUQ5b3JYZVBn?=
 =?iso-2022-jp?B?bWR0MVlQRWxqcjBpczVwd0ZJcHZFT3RGOThRdjlPNDg0L2Rtdmd3OWJ2?=
 =?iso-2022-jp?B?SVo5WlZZRWRxd2RmYkxHU1h5SEpmZEF2MkJpaHVsekJNVVJoZVlpQ0RJ?=
 =?iso-2022-jp?B?YlFhcHNjdEN3TDVCd2lPSTIxdDVFWWRnakdKSUhrdWwwcDEzaSs4UjIv?=
 =?iso-2022-jp?B?THV0ZnhBaTNKUVg2WHB3UnZ3eDNadGRJQXY1OGJsYVJrbnlJK2RqbVkr?=
 =?iso-2022-jp?B?RDk3YnZRZHI1OCtFVE9ycEVEYVhSZzY3dFBaUlFGN2VZc24zb2Y0Nk51?=
 =?iso-2022-jp?B?ZjVCcmhMRkNaQldINlVwRHVNMCs2ZTZFb2IvZ1RpRkt5alc5bTVnNm5S?=
 =?iso-2022-jp?B?bGtKajBvdGdSSHhJVHZVMmluK09DR1N1d2I1alAxb3hrcE5zbkxwWXBl?=
 =?iso-2022-jp?B?R2Q2azJzeDI4VjRjRUZqVlJRTTBpUmNDUE9WMzJBR00vaHpYT0FCYm9y?=
 =?iso-2022-jp?B?ckE5TUVPbEtxZjNoUnBTbjhFd2p4N1BKRnhrUmhJckJTSVZIRmNVSlRh?=
 =?iso-2022-jp?B?ZkZGaUpVb2dqYWU3Nzl5OFdQL2czQW9nUHZ6MllCL1pVMFpnNG45V2sw?=
 =?iso-2022-jp?B?THA2SnBYUklGTithbkowN1p0YjlpK1pTQmxVVVdqYmlYZFIvblVpZXE2?=
 =?iso-2022-jp?B?MWExMVJzS1lxZ1V0bUFvUFEwQTJ0cTZFcnNoSFpaL3dVYURIbW9aaGxw?=
 =?iso-2022-jp?B?TFQ4dGdid0NpNWh3aTI0NTQzcmlEb1dJOUlhbzlUbVR5NmFjMVJ6aTlZ?=
 =?iso-2022-jp?B?WERWTjUrOFE3dEVGeE1DL1hEb1ZtUTFFVkpXQjNKQmVocUc4MTBIZ2dX?=
 =?iso-2022-jp?B?UDRRVnBPNDRlTk1qOFd0WHgxVk8vRFBKRUU5Q1psTSt5emNpZzMzQllN?=
 =?iso-2022-jp?B?T09xLzFISkNiRTFiVG5QeW44UTk1YVdSTVNpZEh3emd5NFlodm5KMGNO?=
 =?iso-2022-jp?B?K0o1dWwvZy9KalhBQXZQZU1GRm9JbFg3cUNkU1BSMFEraFVWdnJEWlhT?=
 =?iso-2022-jp?B?RDdxL2ZxNUNEZ2JEcitBQU9sM1ZsVzdxVlU3TGd5UW9XaEExbTg1dmky?=
 =?iso-2022-jp?B?VnpCQQ==?=
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
	qNQeCRa4hjFIE73aRm/vW4a97cIqK+U1iydchaXb6DPF3OvBnFPt9VXmYdjPIreN4uXWc3VpGsvRJMZcG7Ul4NOxspQGPBIDYKK/JMwkT6j1jevDnOcoKJSofq2MWtt659GkQz1embnmBSauLKPq5gL4W9HxDmp12cQw6t78R1brfbbNlXyAfSD8HW5+JLo7P7WuXcgXrup1eWGsPM/nUB8zS+iu6Vmm/SMjLJSIlkQ3ixl3KPxZd8IilUeQeaUuB+pYqCmnxX7y7uxTHjPy5fZF4RXNLfgy0OrSZJhMG9NJeHrsSmX0yjOOnwHXsyTe2A/KszJar+ujWqOeSu85y4CuRY7hUOhrsJR/si8oO6NEb8lKiCPS848hviWSJdGEgbdPLW8Q8fZqZyD0z4DvGvlyAmcokuHl/KiNPEVYlRwpAXGaheUQZGOwyvJmftz3icY7eIVddqvzN02NERuh5QYAdPd/DIPq+jlzKSAJXFQPyDwWgiQ6x/aN/vCwFQNpsJbhD9j7lt4oWhgPVwuxhricTQL/jBoKAd74SRQCQiEj8yX8SfOtJzrBEYu6X/JOF5KIuO9A0uCSy2M5TokUpjl880Ko1SZvR1PMXKGOlaXtWCQi3hlOmzR//BnGqnHK
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03254c60-f93d-42d8-bebd-08dc577585e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:42:24.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zv/+2PktUACXFOCWodMto7WSP9XBxsUQholaIKgVG+eugh9D42UI2OcKlkIP7GaFpySwAtXhgMgDoIJimdGfyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9932



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, April 3, 2024 10:06 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] cxl/core/hdm: rename interleave_mask to
> ig_cap_mask
>=20
> On Tue,  2 Apr 2024 22:17:46 -0400
> Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > Since interleave contains interleave ways and interleave granularity,
> > using ig_cap_mask is better to describe this capability.
>=20
> Hi Yao,
>=20
> I don't follow the reasoning of this.
>=20
> ig suggests interleave granularity which whilst related to the address
> bits, they aren't masking the granularity as such.
>=20
> I agree current naming isn't particularly meaningful, but don't see the
> suggested change as an improvement.
this is my misunderstanding of these bits, I will drop this modification.

>=20
> Jonathan
> >
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  drivers/cxl/core/hdm.c | 4 ++--
> >  drivers/cxl/cxlmem.h   | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7d97790b893d..9bb6a256cc6f 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -76,9 +76,9 @@ static void parse_hdm_decoder_caps(struct cxl_hdm
> *cxlhdm)
> >  	cxlhdm->target_count =3D
> >  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK,
> hdm_cap);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> > -		cxlhdm->interleave_mask |=3D GENMASK(11, 8);
> > +		cxlhdm->ig_cap_mask |=3D GENMASK(11, 8);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> > -		cxlhdm->interleave_mask |=3D GENMASK(14, 12);
> > +		cxlhdm->ig_cap_mask |=3D GENMASK(14, 12);
> >  }
> >
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *in=
fo)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 20fb3b35e89e..b53f7ae0fdd6 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -852,7 +852,7 @@ struct cxl_hdm {
> >  	struct cxl_component_regs regs;
> >  	unsigned int decoder_count;
> >  	unsigned int target_count;
> > -	unsigned int interleave_mask;
> > +	unsigned int ig_cap_mask;
> >  	struct cxl_port *port;
> >  };
> >

