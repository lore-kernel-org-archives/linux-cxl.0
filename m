Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC633F5A4;
	Thu, 23 Jul 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822495; cv=none; b=KXPjmJLtrFFg4/a0YROI94WFMA+1n28wMdEsBKTo9Axi/HEkSAPzfK+WqIDqXKwPcWkTsBhmT9tkpcAHCz275QRO1qyJAmOBpK4tya6wYCJY011OGN8rwx7M4lE0oruh4DfGgHaeSEVCHa7xvdgboHnr0XdD5xYD4w1C9q/pDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822495; c=relaxed/simple;
	bh=KQlyYudqMNoKpwplZ54s7tyBYprJt2G+01E6JXW8QeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxfikOZVY7PIBufjPejQYkvutnUaRgJGJ/XjiWhcIl6vQZYmf6ayrSlMmlmp2jn+zhjbTqb0cxux7nkG0JsaA8cWTXcT4Oh4JSEKQaWbl9S0fsS/gQsBJhwC8cYiHO4uPQHWBqi1szkpvdjB85YLmY/vFFU5v98cZsg1MVC82Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OdaYgiUv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OdaYgiUv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBuCb3106596;
	Thu, 23 Jul 2026 16:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=korN2Y
	Hqsh8pT9F7lctEfcYhU6wnH85Xri/gBWLMa6Y=; b=OdaYgiUvF5VsUFv0ntdGo9
	23s1sdFL9q2oGZiCtz8rSTBder/AqwvN81qoR53QrHvjD2LDugnJZlrQ73NcgG62
	lyV2gguCoQM6o5aJ9yivOZMB9QjgSK5JkAV6JbVRj8lgj6MNKMSNZDKNi6fvLK5f
	RXBWFgUGwSp9EXcJ9fOOumnrZT+FSfK7R2V8EjQAn68IMa3IL3OXwGGSwhPr40am
	YR/oMfW5X4EM6fZ2dlP+Ygu7ag9aQ9aotNCuRVwhASAoKfaAErFA/i80jJ87kw/m
	12WiwcbV3wWIv8O8R6Afn5x74Zl7iMsRyc7w7/G9IvdD7YWSVMnbGtXVk1ZdHATQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7918e9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:00:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NFnd1n027646;
	Thu, 23 Jul 2026 16:00:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4x5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:00:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NG0eXY47710556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:00:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E18AB58063;
	Thu, 23 Jul 2026 16:00:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C1DA58043;
	Thu, 23 Jul 2026 16:00:37 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:00:37 +0000 (GMT)
Message-ID: <925af65e-89ac-4ba6-a4f6-316b97d209ef@linux.ibm.com>
Date: Thu, 23 Jul 2026 12:00:37 -0400
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/44] qapi: convert intro sections for tpm.json
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Lukas Straub <lukasstraub2@web.de>,
        Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
        Markus Armbruster <armbru@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
        Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
        qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        Michael Tokarev <mjt@tls.msk.ru>, Igor Mammedov <imammedo@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-edac@vger.kernel.org,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Eric Blake <eblake@redhat.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
        Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-18-jsnow@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260723044805.527643-18-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VBysymmx7-i_vvoDQTZTlhWT_AiBBj7E
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a623aaa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=1mmTJrKIPDxWdWRvuakA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE1NSBTYWx0ZWRfX26QsPcGnl7QE
 GVxy+PE+Ap4ev68RtrJ7IF7lXyJ5SNBScFL5Jst0WkDEhYr9R36c7PunE2UcWp+cPZ3pEaTmfD6
 Q8+ZgNTJ6vI89jzGejZ/NZItpw96UH4=
X-Proofpoint-GUID: i_T5eeGgDnNzwNRIS0Bk3XBBlhInfrK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE1NSBTYWx0ZWRfXyf0iTDBlWwf6
 UFO+Oj1cDYZS7ZXgTvjjXMazIzluHC9IMwT5cjvkJYk/S1TKNka7cy4XMr30tVLaCP63J1DC6at
 ffj10/ly4a5s+733G0sTsW2Kg3Di0MjATLgfqUTkeYB3OHLovE3TNurX5bKcbFgXlCuWprWVEw0
 8xp+CYWXDH1bT5r1I/nddFvJ0Cd3WNjKaA+zQcuahrGMOizYxKA+cMshKcoHp6j/xMxgsB2x+Fi
 MPwdMGlbOeeeyTgULmmD+rU/CQ3vA1Cm3Qrrds1B6UfVxb+/89Q+3X9W+yJu7gP0BiYdMG9QKqK
 niCIDWrSuyv76sGvw3t2OPLoe60qkfJsxZAB+4mdSwZiasuHTE++KT1ehV2gKMeTLLR2b4anOWA
 Hwk2hmy2SP8Z2I4l7BIitDMIIrJO1deCcwtsL68g6T9TFZ14yKYnUfTrxquhRR91glYOclypUC8
 Pt9ZUYtT1d/BWvOY33A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230155



On 7/23/26 12:47 AM, John Snow wrote:
> (Trivial)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/tpm.json | 29 ++++++++++-------------------
>   1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 3f2850a5733..6d94be656ae 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -10,8 +10,7 @@
>   
>   ##
>   # @TpmModel:
> -#
> -# An enumeration of TPM models
> +#     An enumeration of TPM models
>   #
>   # @tpm-tis: TPM TIS model
>   #
> @@ -26,8 +25,7 @@
>   
>   ##
>   # @query-tpm-models:
> -#
> -# Return a list of supported TPM models
> +#     Return a list of supported TPM models
>   #
>   # Since: 1.5
>   #
> @@ -41,8 +39,7 @@
>   
>   ##
>   # @TpmType:
> -#
> -# An enumeration of TPM types
> +#     An enumeration of TPM types
>   #
>   # @passthrough: TPM passthrough type
>   #
> @@ -55,8 +52,7 @@
>   
>   ##
>   # @query-tpm-types:
> -#
> -# Return a list of supported TPM types
> +#     Return a list of supported TPM types
>   #
>   # Since: 1.5
>   #
> @@ -70,8 +66,7 @@
>   
>   ##
>   # @TPMPassthroughOptions:
> -#
> -# Information about the TPM passthrough type
> +#     Information about the TPM passthrough type
>   #
>   # @path: string describing the path used for accessing the TPM device
>   #
> @@ -87,8 +82,7 @@
>   
>   ##
>   # @TPMEmulatorOptions:
> -#
> -# Information about the TPM emulator type
> +#     Information about the TPM emulator type
>   #
>   # @chardev: Name of a unix socket chardev
>   #
> @@ -121,9 +115,8 @@
>   
>   ##
>   # @TpmTypeOptions:
> -#
> -# A union referencing different TPM backend types' configuration
> -# options
> +#     A union referencing different TPM backend types' configuration
> +#     options
>   #
>   # @type:
>   #     - 'passthrough' The configuration options for the TPM
> @@ -142,8 +135,7 @@
>   
>   ##
>   # @TPMInfo:
> -#
> -# Information about the TPM
> +#     Information about the TPM
>   #
>   # @id: The Id of the TPM
>   #
> @@ -161,8 +153,7 @@
>   
>   ##
>   # @query-tpm:
> -#
> -# Return information about the TPM device
> +#     Return information about the TPM device
>   #
>   # Since: 1.5
>   #

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

