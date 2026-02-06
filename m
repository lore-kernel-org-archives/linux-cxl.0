Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6717993
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.138.35.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400911; cv=fail; b=hHjc4+0HpJqS2OD8DBMUlb85SrtH/LTB/AOGpLC9vwT6dEnKZjG0mmy+mjINn4MQsbB9Elms6syy+sXbVz/FWMX0J9F4FIN5nvC1NyT3I4dKe0Uuq4mBjINfnvOS2nAlM7ja20Molwhxhfv9zOARcnpof337NWQGl2z7onCScE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400911; c=relaxed/simple;
	bh=wpe0/2kkGk39HotGvShsN9e2bsM6VMjbcWHER6HllsQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FIgfrnptgCRxCzRK46QMfVklU+begBEWXQndQlz6C/qSwsFIZGiOF8ofisFBU4EpvI4zYsnWKj5RVswf2HNEkBDD1kxQSHXtRcjHb1V4LnVld5Zf6lCgLYI0ZmEfjdWyk5rzmdz0rx1tI5cjPWY5tZS4wvhO0c+pikqQSYUHMAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=ZFUNkAPu; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=Q7cWlEi2; arc=fail smtp.client-ip=139.138.35.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="ZFUNkAPu";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="Q7cWlEi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1770400909; x=1801936909;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wPw98Lv74dqTIrivb0sVul69Ru+k2rlqsosDyHAl1kA=;
  b=ZFUNkAPutUoJrfuHKXe9MG8jgv0UxtKR5vDXDur6FjROq8bTwAZFBjFR
   U8mw/t0mHvPVcRg+CTAWdnM9Win7ozjynIRzHLKzz1mJrwE4pmr+ootMG
   8F7cwK9q31+R3ZqI6aRnSAvD3zqF8sz0fqhkOqoVJCV5VL+n9Pq3QCYqK
   Y=;
X-CSE-ConnectionGUID: m0WLPDwJRqWAUdPoOI5unA==
X-CSE-MsgGUID: o5o1iYwlTiq4FI2hbULZmA==
Received: from mail-ph0pr07cu00607.outbound.protection.outlook.com (HELO PH0PR07CU006.outbound.protection.outlook.com) ([40.93.23.95])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Feb 2026 10:00:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2NH7jrMSoiJ4tXu2PWv0YR5ycQMGBslywTSA2zT/MOa57eYRvTVHcSYBMOvMk9pkc6G2tIJaop+lehmAdk4WZUszFP+xkQvQPiQ/tz3w7PmmPJMFfmrfNh1Ld06ae4JD0s2LvnFWYt5+kJnJunVt9ArLbTDTRyi+ebvxl1e68vYwaR7wdX3CjRj9WQBK4Opdf9eIydJ9JkpKvIOZjw8cG5S2V0iXw2f3tps1Al8MEizW6ZTy/VBQ25v1SKglE5yeXHTIHxzp4nOYhtG1aC9MZyclWBWijdEYchSC7JovoGwYRj35vE9s9hkL7PEcuqJhiV4eCAUgwQ7iSSA1Kt+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPw98Lv74dqTIrivb0sVul69Ru+k2rlqsosDyHAl1kA=;
 b=T23Svph0+nr/7SVlzVb14LDKxpq74t3BdTnPN6L1/CRNKQMInzQwG4SPk3HTcIHtZMEEPpOO1GDHlIdEQRcicPR+3zIPqKFGPR6LiCGmnlxIKXldPcwZRXYnKFX6iSLmmG+zhPjWjJ2/CWLahlBZricToaeagHRx7vsGE2OMiBUXfZPDr1oZ3QcDSyL+75fG1mOPyPTdBPbq7z7zItkOSUEDu1fWa7/EsfGxYht2YMR3Thu8zEZ17tBnKsXvvU9G25BHrBrUgERQsUNUZ2erRzYPUt2mIBk3iI3nq3wVdfOIn2oejfwiQPt/otdj/Ka1LIm3AxWsd4ZardGD12/V5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPw98Lv74dqTIrivb0sVul69Ru+k2rlqsosDyHAl1kA=;
 b=Q7cWlEi2/5Ull9Rrmso8M8slAl7VBycTAUjfLnFkER2SMk+6BTALF1Ng3hCg+2p9bI8CKlC/cQMaIR58FhU41qMHcABKm0NgnVVv5ldlqgCIR5H7sR0zgCyLwaLcNcrt/euCYOPtDYmPFNeMOdco8ck0IU92gW71jIzT44PWGRA=
Received: from CY5PR20MB4747.namprd20.prod.outlook.com (2603:10b6:930:29::20)
 by SJ5PPFE41A1F1FD.namprd20.prod.outlook.com (2603:10b6:a0f:fc02::aab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 18:00:39 +0000
Received: from CY5PR20MB4747.namprd20.prod.outlook.com
 ([fe80::6208:6f12:f785:f936]) by CY5PR20MB4747.namprd20.prod.outlook.com
 ([fe80::6208:6f12:f785:f936%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 18:00:38 +0000
From: Hongjian Fan <hongjian.fan@seagate.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: cgroup support for DCD
Thread-Topic: cgroup support for DCD
Thread-Index: AQHcl48tTxXHbq2jYUSBoqBO3TOJkA==
Date: Fri, 6 Feb 2026 18:00:38 +0000
Message-ID:
 <CY5PR20MB47474A4D5CFA5E7284328F6A9066A@CY5PR20MB4747.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2026-02-06T18:00:38.290Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 General
 Information;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=1;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR20MB4747:EE_|SJ5PPFE41A1F1FD:EE_
x-ms-office365-filtering-correlation-id: c994f7de-d3d4-4a66-2e80-08de65a9a2ad
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CZec0fzSV6zEwjtiNMrDDbicTLH4FNbrp+LeJpeu/zuc9bBHZSEn3jgsYm?=
 =?iso-8859-1?Q?NP2lhYHJo1duPi5NKiTHpkmXN1KWfr2HbYQ5OTrRO0AgdIzN4LgVssa9hp?=
 =?iso-8859-1?Q?xTcCQJZ6wMdx6IkHISDw3F89UVEIGeqxeLswQoULYOxxLfEdUsbE8dEuES?=
 =?iso-8859-1?Q?FmIpQ3ZvpHra8eOwhjbF+MsG+Zt5gWyogeraGSQYWn7/NzFOPjBeNig7Cf?=
 =?iso-8859-1?Q?Zz1fP/9sNcGHbj41YiBKZ6m4yzw1hOFDq5pQ3R21gMivhtDrKPLyJJxLhR?=
 =?iso-8859-1?Q?tweyeROV3VT6lcsQD2wopR1NeJujMDAU2E+7IxElkEXRDZU1fR7JWaawU0?=
 =?iso-8859-1?Q?668OqoLaCGq4mpRwxss85BTkOVqJmIamuOcTCBkHgsfIddAiluEP+ls7Kl?=
 =?iso-8859-1?Q?XPIa63bFRJsgZBF4gq+hMttDaRiHrqRLHiNlts0im5+K0xB2Tz7XFQQytC?=
 =?iso-8859-1?Q?OoNdPWQTteWZeurRh3Kvrqyj9SQ2W2X9F6E/JbtqG/6AuuqPKrymxuDjvg?=
 =?iso-8859-1?Q?KgzZoyOfV+HDBKgXao7CzI4AyyerwFkEvjFHphUJF8pReWqd18Smj2ox3X?=
 =?iso-8859-1?Q?5hbYEDrFMaZU0gm4UkpsB9NylCHmkXsia9solJRO0TATKWn2PgDgdGQVor?=
 =?iso-8859-1?Q?EFvBqFv+U4kX7jVxKWFpTJhGWc84v8RPqoL1TeLlaeXeYDIlgyMROzBwI9?=
 =?iso-8859-1?Q?Bo5YEehfsBK1lFLGaj03E6Zprb3k+ZtsIDeZPSx7Gfmgo0ejkl4ccJEGB4?=
 =?iso-8859-1?Q?eFbkP0ppj6wf/zDjqOXkMuuPZP13LVHVN2Utd/PFXcPS1ylS48/4vppT2l?=
 =?iso-8859-1?Q?YP6b4xg0Z99YT+HKkQvb1ozZKDCJa8vDQ1n3EL71FkToUbajDUnRSMgiZp?=
 =?iso-8859-1?Q?iwfSwQZIotxjXKNqzQ1LHxWFgSk+4RTCbIi0g+gAaf3xdB0KUbjhk7oA/d?=
 =?iso-8859-1?Q?R01HqfkTTYRTAKwZObAtQQEoIcw0G4TAGlaxTYQ/2+kiZ2Dad5ieevwiRi?=
 =?iso-8859-1?Q?6OkOV6CUsSDSQamepTf9IT0NyAO2j1YivouBqTR9+B9chj2nWWn+nBfgOk?=
 =?iso-8859-1?Q?2s8D8+gOZuHrxptmfhy4IQl7MIvAqJVnDfRahGkhaN7bm/CMoSHoHwad0Y?=
 =?iso-8859-1?Q?j/XbP4yYRlVZTHExl4wRB5LqLhS9kBb0O55aiciRYw4tdi13xQcMdhXJ/8?=
 =?iso-8859-1?Q?1irE5vZjuKhb6PFS1W/ghNLEMLlN+WHWXYdWB+Pf4ijkC3+BRyNmWJtuQO?=
 =?iso-8859-1?Q?mioprtWX/C3gM+oIl5bHeTMYaR7SSPvH5N8ul8OgynJjay/CtcZKVIBl4J?=
 =?iso-8859-1?Q?JzA/KaO29A0l+Fe+FH3wKqvdIlWVvu+Jsv9i6RQz73foGv3YFex+LjRj7k?=
 =?iso-8859-1?Q?Mr7jJsYo74k7K5Oidl/JgLcFpjsQNRdMSbWrJvbQS7oVOvle8I7MDr+ZMB?=
 =?iso-8859-1?Q?Dk7jvLTaxNbU27c/3zswz/+raQOtJnIA9Fcpb5JpEgD+EYytEiYPnKMjs7?=
 =?iso-8859-1?Q?xyaPKkFZnK8Zuzx5+6GyeToII1Y8l3t+s+F2NZAt8yVRlXkAqldEXKr8Sf?=
 =?iso-8859-1?Q?US10ZFKNPnmTtxqWFFSZ+Vk5oEIShmq7izpYG2n9oBhBZ/7H1oJXHQkFHh?=
 =?iso-8859-1?Q?vwMOr5iDKXdoVFTXNHSfK2FM2f8mGmpv7ys/rk+ljClFsw4SdKjx3kp+SL?=
 =?iso-8859-1?Q?RQ0rHOioPQyR1mWo6Nk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR20MB4747.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?w+M5HTrkrS2Pjr3OipjhR5j74lzJEYWr7KiD3G2HD3Otc5mRMSVBm1Jg7E?=
 =?iso-8859-1?Q?XA4e8BnNSqos6jUgLoE2yjtaP6Pva9dE7VhEyCY8foBhmnqKoJwWyK+B71?=
 =?iso-8859-1?Q?yPak/+aF3YbcvAGpqa2fbXoDSuFwLKYI3HgjkxkZxnN78zsW8E3gAIvPDO?=
 =?iso-8859-1?Q?lbLAQxzjQLl8pTGWo5xEIGbo7Up/G85kGy7FFEPHd1WhDoJzihOmlvK0zQ?=
 =?iso-8859-1?Q?BGFxZcZXjiyRRfd3ynN4mTCn2hQ1v1JFec5ABXvCuDKTFw0OiKIcjX3DWv?=
 =?iso-8859-1?Q?50XTT9gg6dlmXWAqsuW+lqAmTaS3q2BhABXgFn3WEVY1vZ/dxN9NGmQTAd?=
 =?iso-8859-1?Q?btbpqCdkoj1Rc4gwoLpvDTiSNKe0JpnrL2ecgOZYEKEUVinaTdQWulbRB7?=
 =?iso-8859-1?Q?N0wpwSqKYST62eVE7ewB4Er04BoxELD7EB6Wuj2HVUV+xFQWqPP/CWLh42?=
 =?iso-8859-1?Q?Sa2cC1JxG2zSdI1g7Qtxq/+P30hcg0jPjaIgRP8Z+aMBGOlq8g1P+UJLJf?=
 =?iso-8859-1?Q?GpJuHaaMM3sK9byQh67Cn+1kZ4uL5cvRBMvpPUTjconoKMNALqHysq5HFB?=
 =?iso-8859-1?Q?xJLK3Lm8vTdaJKtIFhPVILJPd1jr6AHRmbbpwuvIxXiVBVkgyUCglPUATY?=
 =?iso-8859-1?Q?/hRSqx3ISk/IIHPEwooFgOtZaniLRIb00hgfQ7yZI9Ttbkh57pjS+wXNVb?=
 =?iso-8859-1?Q?jHSDYH98LCkewWb/X2v0ogt2Zx6FLYft9vVERs5YAUq54J9na8cZvqxGEm?=
 =?iso-8859-1?Q?NA/407/rS2hWOGfofTjpUeSsD69dy5iO7U2+9rnhOZrGPIYYtkDBCRkZPs?=
 =?iso-8859-1?Q?VYFtnu31cvODUVNSXE6k5krzbBQel20IMBBeEOUAHJ/tCsVyy/JAFZRko6?=
 =?iso-8859-1?Q?lZcxLvFgE6Cods0/8wmNtmhmZbYE65kopcHEdTEZ1QQnTgXL2fWGjU+gt+?=
 =?iso-8859-1?Q?pTPNPQIiUq+aQOWHK9yCBwmxw2FB14uZC44gp8XPRccjl5VfPjdizd4+yB?=
 =?iso-8859-1?Q?cIMgX9+qsLAuwPHM/aI725G9Mb713sLEDnn7vCXX4fvOuahJETNONsdoAo?=
 =?iso-8859-1?Q?R2/DrP8rldJK3avPpGcvhje93PJGDCn0a/EitmfnSEGARTR/lLDoBjlGD6?=
 =?iso-8859-1?Q?IOJheeqzeHf1qeneU63UTVqVVXbeXhBYirIoEQbckV6bwXu0A8awerYOse?=
 =?iso-8859-1?Q?qMLuRXz7YlWHsq7ZAJE743OJW/X6+skc+REzjT95R58niwGEagBW0AbJut?=
 =?iso-8859-1?Q?wmnEVxP6DW4MDRv9Yl4Gqt+q8Nnia8RiVPhtPTillSJnLjH2vmsksOLgfg?=
 =?iso-8859-1?Q?AbSuI18JsEDBUhsiI1nrM3jznyuzlVm+aE8bg3DddrGIil61CLDrrRGL1K?=
 =?iso-8859-1?Q?7RYxPtecsDsBtPU/Bew6bfIGBt7aApFAsnhHIiR9UJpozPMaTLO8elwmtN?=
 =?iso-8859-1?Q?dxkNqFQ0l85qHGqiMsNKiSGuCh7ywR5jspHo6wlyDdSGAJaVB7dNI6W6nI?=
 =?iso-8859-1?Q?8AQ5f/Nf7sezXTBYkuq6gyud80JRhrDl3tcY66iaRXqdJ8iVuY2L255VXr?=
 =?iso-8859-1?Q?MMJm/+ddks/fCsAsl3W4qoX4B+IjFYg0XkGN7A58iQ14Rht6gC2yzrLGE/?=
 =?iso-8859-1?Q?csN24Ns29Di6QSa7HBN8cZTX+25SKphAakfsIHuoaVIN68OtgPK9ScYMyD?=
 =?iso-8859-1?Q?nYOyk7UakqKSWDklmUHH2yvdM0qwkMjMfw943VaMQXbix1WUrYHuKE+3Tz?=
 =?iso-8859-1?Q?lQtSpp/OS0/7Kp1z/l/JnTpR9tx1FPuZuxO75tX8o0oUpzRubEo8KoYkW+?=
 =?iso-8859-1?Q?v5o0ljMxQA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KJveFcpJziV9CsEoTySsIOZKlvSt1iCE62f+S3ZU/EOCct5IwPmKxj2NGhudWKtfmaDe2fPA/m2rCn5wAjD+HhYkHnf6KrDc8IzFqmYYTsqAkhaVkgM6EyBDsDNkuWt/FCgNpBJeGq9cXSU88nFMRFiCl2RadKwZUWqxuVwnCmyvaxL+WG7yCLJpgDkLTR5PFVQireFi8iPWUsZB0BpP5cOC9VvZRrQMQXgHPjdAJwldy2OapH3FOUpsYnV1AOM9Bp+3cNPBwABkZCk14KhnDV8VdQraTQl7K8zc7a/33WLJmygHv2lJSdm6YTTZ2pRBuRt7FVQn+SpSsH5S8cTzyfGSrpsIVwfcspbMi8R0HPVitvacoSsxMfoJQ6++HX0aTjX9jPuWuW4qul6aziI8q1et/6mBW3URqWHxt2pRLX4FZq1mRZblwcTTT37DpJJc3ROg96MciUIst4nHDyPJXsKA3LfaY1PwOHG/suD29kinIE5TLZQMIKrelpBNo1TmT6PWA28fIsRVU0yexaS9PD0tR+gz2NkebxhDrZ2ks3uP+uSeNUiYE0RTI/d69xIWBbccoag2Hefvx2drnIPBjTvKzL8x1o+64iNAZ0Nz/WXjxgF9F5bQtm9czvduFiqx
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR20MB4747.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c994f7de-d3d4-4a66-2e80-08de65a9a2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 18:00:38.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgWoQBf2Z6xx3uqe3jm/nWmB9nEoKqtQbm/ZS6DueYPlfRPcjw/07BuQGWEyfKbQiDVn5A3tGw2OHmweYPW5v8oxc8P8EX5TIcG0alDq6cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE41A1F1FD

Hello,=0A=
=0A=
I would like to check if there is existing methods or any plan to support a=
llocating DCD extent through cgroup, which could enable DCD to the user app=
lications without code change. This would also be a good way to use DCD in =
container environment ( for example docker ) or other software already usei=
ng cgroup for resource management. =0A=
=0A=
Use cases:=0A=
=0A=
1) Expand the memory capacity =0A=
	Creates a new cgroup=0A=
	Add DCD extent(s) as system-ram private node(s) for this cgroup=0A=
	Bind cgroup memory to dram nodes and DCD private nodes=0A=
	Set memory capacity limit/tiering/numa balance policy/etc=0A=
	Start the application as normal / launch container with this cgroup=0A=
	Release DCD region=0A=
	Remove cgroup=0A=
=0A=
=0A=
2) Increase system bandwidth=0A=
	Creates a new cgroup=0A=
	Add DCD extent(s) as system-ram private node(s) for this cgroup=0A=
	Bind cgroup memory to dram nodes and DCD private nodes=0A=
	Set weighted interleave numa bind policy and interleave ratio=0A=
	Start the application as normal / launch container with this cgroup=0A=
	Release DCD region=0A=
	Remove cgroup=0A=
=0A=
=0A=
Best Regards,=0A=
-Hongjian Fan=
