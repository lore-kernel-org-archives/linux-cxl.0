Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9837D11A
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680593; cv=none; b=p8e4ISvAIm5x8/JTbDFJyZfqcfMRtWSMQzwdS4ytzH6bXZY8owYfRdAt8gdb3l9dsQNHLH9dnCm+lUyCDtCTdPMbWUWmkhCLJaFINjrReQ5iNdhC+TSWgqM2tRWcetddN1djKygcAvpLARWoHZR81zJViY56qsVbodHe9/5IYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680593; c=relaxed/simple;
	bh=ZhUWzLZmBG5uq0IMiKCNTFNBvqEKY3XvzwCsndA/sX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEvlVpNezWs08hwd5T3fzTJK4pSfRJIiOB8AvuFOoFqNrvMwHkmsrjkco+flcrpGyQScB8YdXbqDnPbSG2BZ3+lNbW1sQXGFKa+G3EGrCymUAGNhWfuZypuRhI8hGR2A7aRNnnPk1UgViH2+sk89gdYrnvZ4Hwy9xfA//1tcxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll2nhGgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll2nhGgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4883A1F00893;
	Fri,  5 Jun 2026 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680588;
	bh=D97khVO6e4ZjfhNh87z1K7Z9Rz2u8ny/5mLSUGvfU0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ll2nhGgV2oZI4bKEuRaaJRnP5W4Fue8v2A9TYh6aSu7MQYBBWZ1ZoAJdek4Lfp1qh
	 4KC5L85ecwDcq4/rWZ6mC5qELDA57LhBrN3DXUsCVTEQw5cl8u1zC8IgLSwM91VF9s
	 AUbULr3vgVPzvyX+ub7XfOPIt8r62DoS1UKv1/g77hMcxxbhu2tXFPvFVfCX6Yy+en
	 6EnJxpDZ7BKPsN1R1K23nv3uEQOabrxCuC9IY+CCrB7NcAWsDXTTTnEAvkqcvXNhdi
	 XfusIxOPjoqzeWzNLrg3BaNiZRC6clXWyIx3kbncxKglQ8zD9xdM08vQyk/6BrJHJ2
	 9gxAJ2OvNxMKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/test: Verify cmd->size_in before accessing payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605171107.3855381-1-dave.jiang@intel.com>
References: <20260605171107.3855381-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:29:47 +0000
Message-Id: <20260605172948.4883A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in payload bounds checking allows massive out=
-of-bounds memory reads and writes in `mock_get_log`, `mock_get_lsa`, and `=
mock_set_lsa`.
- [Critical] Feature handlers blindly write to `cmd->payload_out` based on =
parameters derived from the input payload without verifying that the destin=
ation buffer is sufficiently sized.
- [High] The `cmd->size_in =3D=3D 0` checks added in `mock_clear_event` and=
 `mock_get_test_feature` are insufficient to prevent out-of-bounds reads fo=
r payloads smaller than the expected structure size.
- [High] The patch misses several mailbox handlers that dereference `cmd->p=
ayload_in` without checking its size, and the fix in `mock_get_test_feature=
` is completely bypassed by its caller.
- [High] `cxl_mock_mbox_send` does not serialize concurrent mailbox command=
s, leading to widespread race conditions across the mock device state.
--

commit 26d56860aa1c2848111addf4d017916d442515a1
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Verify cmd->size_in before accessing payload

Adds a check for cmd->size_in before accessing the payload. This prevents
potential dereferencing of a null pointer if size_in is zero.

Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.ke=
rnel.org/

> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32c..5d812b10fbc87 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -312,12 +312,17 @@ static int mock_clear_event(struct device *dev, str=
uct cxl_mbox_cmd *cmd)
>  {
> -	struct cxl_mbox_clear_event_payload *pl =3D cmd->payload_in;
> +	struct cxl_mbox_clear_event_payload *pl;
>  	struct mock_event_log *log;
> -	u8 log_type =3D pl->event_log;
> +	u8 log_type;
>  	u16 handle;
>  	int nr;
> =20
> +	if (cmd->size_in =3D=3D 0)
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but is the size_in =3D=3D 0 check sufficient?

If userspace provides a payload with cmd->size_in =3D=3D 1, the check passe=
s.
The handler then casts the truncated buffer to struct
cxl_mbox_clear_event_payload and reads subsequent fields out-of-bounds.

Should this check verify that cmd->size_in >=3D sizeof(*pl)?

> +	pl =3D cmd->payload_in;
> +	log_type =3D pl->event_log;

[ ... ]

> @@ -574,14 +579,19 @@ static int mock_get_log(struct cxl_memdev_state *md=
s, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_mailbox *cxl_mbox =3D &mds->cxlds.cxl_mbox;
> -	struct cxl_mbox_get_log *gl =3D cmd->payload_in;
> -	u32 offset =3D le32_to_cpu(gl->offset);
> -	u32 length =3D le32_to_cpu(gl->length);
>  	uuid_t uuid =3D DEFINE_CXL_CEL_UUID;
> +	struct cxl_mbox_get_log *gl;
>  	void *data =3D &mock_cel;
> +	u32 offset;
> +	u32 length;
> =20
>  	if (cmd->size_in < sizeof(*gl))
>  		return -EINVAL;
> +
> +	gl =3D cmd->payload_in;
> +	offset =3D le32_to_cpu(gl->offset);
> +	length =3D le32_to_cpu(gl->length);
> +
>  	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
>  	if (offset + length > sizeof(mock_cel))

[Severity: Critical]
This isn't a bug introduced by this patch, but does the offset + length
computation overflow 32-bit boundaries here?

Because offset and length are 32-bit unsigned integers derived from user
payloads, a very large offset and a small length could overflow their sum
to a small positive value, passing the size check. The subsequent memcpy
would then allow a massive out-of-bounds read or write up to 4GB away.

Similar integer overflows appear to exist in mock_get_lsa() and
mock_set_lsa().

>  		return -EINVAL;

[ ... ]

> @@ -1415,11 +1429,18 @@ static int mock_get_test_feature(struct cxl_mockm=
em_data *mdata,
>  				 struct cxl_mbox_cmd *cmd)
>  {
>  	struct vendor_test_feat *output =3D cmd->payload_out;
> -	struct cxl_mbox_get_feat_in *input =3D cmd->payload_in;
> -	u16 offset =3D le16_to_cpu(input->offset);
> -	u16 count =3D le16_to_cpu(input->count);
> +	struct cxl_mbox_get_feat_in *input;
> +	u16 offset;
> +	u16 count;
>  	u8 *ptr;
> =20
> +	if (cmd->size_in =3D=3D 0)
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does checking cmd->size_in =3D=3D 0 fully
prevent out-of-bounds reads?

If the payload is smaller than struct cxl_mbox_get_feat_in, the check
passes but the cast causes an out-of-bounds read when accessing fields
like input->count.

Also, the caller mock_get_feature() seems to unconditionally evaluate
uuid_equal(&input->uuid, ...) prior to calling mock_get_test_feature():

tools/testing/cxl/test/mem.c:mock_get_feature() {
	struct cxl_mbox_get_feat_in *input =3D cmd->payload_in;

	if (uuid_equal(&input->uuid, &CXL_VENDOR_FEATURE_TEST))
	...
}

Because input is cmd->payload_in, this leads to a ZERO_SIZE_PTR
dereference before the newly added size_in =3D=3D 0 check is reached.

Other mailbox handlers like mock_activate_fw() also appear to lack size_in
verification.

> +	input =3D cmd->payload_in;
> +	offset =3D le16_to_cpu(input->offset);
> +	count =3D le16_to_cpu(input->count);
> +
>  	if (offset > sizeof(*output)) {
>  		cmd->return_code =3D CXL_MBOX_CMD_RC_INPUT;
>  		return -EINVAL;
>  	}
> =20
>  	if (offset + count > sizeof(*output)) {
>  		cmd->return_code =3D CXL_MBOX_CMD_RC_INPUT;
>  		return -EINVAL;
>  	}
> =20
>  	ptr =3D (u8 *)&mdata->test_feat + offset;
>  	memcpy((u8 *)output + offset, ptr, count);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this code perform a
memcpy into cmd->payload_out without validating that
offset + count <=3D cmd->size_out?

If a user provides an undersized size_out but requests a larger read via
input->count, the memcpy will write past the end of the dynamically
allocated buffer. The same pattern seems to exist in
mock_get_supported_features() when writing to out->ents.

> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does cxl_mock_mbox_send() fail to
serialize concurrent mailbox commands?

Looking at cxl_mock_mbox_send():

tools/testing/cxl/test/mem.c:cxl_mock_mbox_send() {
	struct device *dev =3D cxl_mbox->host;
	...
}

It dispatches mailbox commands without acquiring cxl_mbox->mbox_mutex,
which violates the subsystem's synchronization model. Concurrent IOCTLs
from userspace can execute mock handlers simultaneously, causing data
races and corruptions on shared mock structures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605171107.3855=
381-1-dave.jiang@intel.com?part=3D1
