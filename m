Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDE7E
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W+7PoGbm"
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9384D46
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 11:39:27 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1f256362bb5so2932329fac.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 11:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699904367; x=1700509167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrL1XLVzLb8TxMft616/1RJDgeTtUmwP8WbM37Se8i4=;
        b=W+7PoGbmg9le8G2m5d1yJJgxCeK9v0JbrHUYFKTti/gHhiNDY10uftw3I/jc0hJKFj
         6W4WOL1iv0gDts47dUDvwvG+rU+6/6MyJ+t0dZc4CrQGlX2NQtYOE0SP3qggmyN11TQH
         +HmCJnrIm8hpV9mNwvahujo+fMiu7V4AHHyeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699904367; x=1700509167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrL1XLVzLb8TxMft616/1RJDgeTtUmwP8WbM37Se8i4=;
        b=Snp+iENmdhkSrup2HYiwVwNcXnsgswDgZX1+Aufd43pvzCWwiTJA3nTDGBtP1G53eP
         28Liz/xo8wVeUlk+3grT3Kxis/2ZAPKrAtZ6JHXb3cBpl8HQmNlFBpNjRVlKOAWPzuKT
         d10wehP16XHDwdZLBXox8MO8mH/SRfrC4b/3AI8kxY6eQb14JJeYgkQITIDd0CcBcS2Q
         O+cgzsbzHuh0ZgrcjfkW9kcsCw+GAqNEy2IoC2Bb2VpvkrApbhJwGE8FLoQBk1Do9okH
         TlaygvKZqC73fKYXRTNoDl7D12h9MybafnEQpIJp2lKN+3AgiQHAr+YaO3/x6IkItAK/
         kxsA==
X-Gm-Message-State: AOJu0YypF5vsYBKuh7+Jyfr0aELkWMthB9Lg4QDLF64wpoUahRhc5SS2
	wdlz1cS8iJaL7ZMdENUWDqpP9ybG5NpfAMcINaqk8Tyk6lFEagp9GXWhH+qkQ5Fz2xfHvytDsWd
	SVph54AjsC+W1QEW84fixmcJFQpk=
X-Google-Smtp-Source: AGHT+IG9+M3g3a9l0LKZOfNF89ppZXJdELdwbR7Rs2RyTxSpZ7L3a9r8iNLcmYbycarw7nFWU7+VvX7mWk7PFXZE4nI=
X-Received: by 2002:a05:6870:3285:b0:1e9:c59b:a9af with SMTP id
 q5-20020a056870328500b001e9c59ba9afmr10008198oac.15.1699904367130; Mon, 13
 Nov 2023 11:39:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
 <20231016125323.18318-2-Jonathan.Cameron@huawei.com> <6551693f988f1_46f02942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6551693f988f1_46f02942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Date: Mon, 13 Nov 2023 12:39:15 -0700
Message-ID: <CADbZ7FptPTeW5yiGxkQhUUMjUsk7PhjO=V3gBL5UZVGPdfdECA@mail.gmail.com>
Subject: Re: [PATCH 1/4] cxl: mbox: Preparatory move of functions to
 core/mbox.c and cxlmbox.h
To: Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f941df060a0dd3df"

--000000000000f941df060a0dd3df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>>Given that the CXL mailbox format is being adopted by other standards
>>efforts in PCIe and OCP I would expect that this functionality is better
>>served moving out of cxl_core.ko into its own compilation unit.

Hi Dan, Jonathan,

Agree with the statement above, and in fact, I think that there should
be a way applications can send CCI commands even from hosts without
CXL root port.
Consider a CXL switch that is connected to two hosts, one with CXL
root port, and other having a pure PCIe root port.
Ideally applications on either host should be able to communicate
with/configure the switch in the same way from both the hosts (CXL
capable or not).

If the CCI mailbox driver is completely dependent on the CXL root
port, then it will not even load on a PCIe root port, even if we
implement the 0x0c0b00 class code in a CXL switch.
In this respect, a CXL switch can implement the PCIe MMPT interface
too, so that PCIe based drivers can access that interface to send
mailbox commands.
The idea is, even if the CCI mailbox driver does not load in a non-CXL
root port, an application can use the MMPT interface to manage the
driver.
Please let me know if you think that will work?

One potential problem I see is that in CXL root port, both CCI and
MMPT mailbox will be available, which might lead to conflict if two
applications use the two interfaces at the same time.
Ultimately I think having a root port independent mailbox driver (that
works in both CXL and PCIe root port) would be helpful for switches
that can connect to both CXL and PCIe root ports.

Would appreciate any insight on this.

sincerely,
Sumanesh




On Sun, Nov 12, 2023 at 5:10=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Jonathan Cameron wrote:
> > A later patch will modify this code to separate out the mbox
> > functionality from the memdev.  This patch is intended to make
> > that a little more readable.  Related move of cxl_err(), cxl_cmd_err()
> > to make them accessible from other parts of the cxl core code.
> >
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/cxl/core/mbox.c | 261 ++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxlmbox.h   | 146 ++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 148 ++--------------------
> >  drivers/cxl/pci.c       | 265 +---------------------------------------
> >  4 files changed, 418 insertions(+), 402 deletions(-)
>
> Given that the CXL mailbox format is being adopted by other standards
> efforts in PCIe and OCP I would expect that this functionality is better
> served moving out of cxl_core.ko into its own compilation unit.
>
> Something like drivers/cxl/cci/, that CXL can select. The s/mbox/cci/
> rename is a proposal to both drop a letter out of the acronym and
> perhaps make the code a bit more discoverable / palatable for folks
> coming from those non-CXL specs to find the Linux code. However, if
> folks think that's too much thrash I am ok with drivers/cxl/mbox/.
>
> As for the policy for raw commands. I would still like for there to be
> some discipline of registratants to this facility to classify production
> vs debug commands to give Linux distributors a single place to set policy=
.
> I.e. keep up the need for consumers of this to define "Linux" commands
> to avoid the "raw" warning.
>
> That said, how much of what switch CCI wants to do should be an ioctl()
> ABI vs sysfs / configfs? The raw commands are really only there for
> prototyping until production flows are established.
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000f941df060a0dd3df
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDG3N/v/7cXC4xYP/YDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTIzMzdaFw0yNTA5MTAwOTIzMzdaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEFN1bWFuZXNoIFNhbWFudGExLDAqBgkqhkiG
9w0BCQEWHXN1bWFuZXNoLnNhbWFudGFAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAsuiZfUgi9027cN+iQrYjDHStIlbjoJWWNwczYntRKg33D9vp+AVA1FV9sHTq
vC+5D42TNZY/dJZv0cwb4JWxZa0ZG3BJzvkpsRJNUreSojb5yuBrY6Tr8Hav57NDLZAnynhV3xZ6
iX6Wa0JFKZIept2rdGV201AJmgVaDZsRFPIpfHeRsUuTufDWr5A/2hVVTvQt7hQmgXyyQzcii9I3
zekCl3pjcoOObDAkznDD9vlyLLvDDWikUDmc6Q82vNt89t6IYnDV8PrsTGMlK2Js/LyhYHN3d/sQ
dBHV3iBHyeN6pUKZ0sDzQMKjzE2S0IRRX6Mwh+DYAUDm66pjXc8FOQIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1zdW1hbmVzaC5zYW1hbnRhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU6TFlZ1Wo
0dmsZDo+/EXAseKlvxUwDQYJKoZIhvcNAQELBQADggEBACxY1CWol9aZ4MJi8uYcPC6El2gUSbiO
NySelOnmiuTKCJRj0e5NJqm6X7p7kN/JEqPy03YjEMTvqYCGcc0ExTQf3RPYeZzaQSrFr3oc9k8N
EGmluzckC+UTGlwVoo38RG+V/ixlatLYgSLqvrKV1h/wX79onLyMMlGR1yZUburAx5qpK6eE/EHW
o6GtvueloW9jET+RFa16TbcDTDio24qwqHELYzgk/PngQbUU82erdcVP80Rr7rWwC5XtbAB6cbjb
mca5iAjoc2SCWnNGFtyOQ5hUC10AMZrPOP4hPodpkP+FJR35N4NiEg6amrNvmPIEadV2JkyE0qVa
fniK4LcxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxt
zf7/+3FwuMWD/2AwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOBBSE+wwwIW4BEf
sb4J0lnC5aoPU/AKPh8UHQ/twe5AMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTExMzE5MzkyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBTIN9eg7X3iwCUjI92GrMRu0+4/BeNonF1
UU4YqN1QiFNRpdFIU3yAMeaQuudZnS0MfxPJs6vkvsjJyPZD/FMRIfOl+2rHjocxyRgqu1nyoJO/
W35HtoQkYZYyZHBD7o23ScmYKc71ylvzKsSX5z4SQCxh5jXCnIuV+LJ4QzuqSXgDA0uZaFrNZ+zu
kW5b7PdORB+Uyurih8mXhoNEsH3O6bv4XbRoh0xM/EA/KDW9VFuKxyjjXfbLTRzsK43kKc3C27TF
P5Ov6Il7hFxczKJZDNLrUzEkD3B5vQcItB9PY8G2NA6aHZf5X5LRZ3MPxW/5gwe/hqep+kv/5pmL
Zscw
--000000000000f941df060a0dd3df--
